class UsersController < ApplicationController
  layout 'template'
  
  before_filter :authorize, :only => [:users_admin]
  
  def index
    @users = User.search(params[:search])
  end
  
  def new
    @page_title = "Weefolio - Pricing &amp; Sign Up"
    @user = User.new
  end
  
  def edit
    @page_title = "Weefolio - My Account"
    @user = current_user
    @plan = current_user.plan
    @us_states = US_STATES.collect{|s| [s[0], s[1]]}
  end
  
  def update
    if params[:plan][:plan_option] == "BASIC"
      redirect_to edit_user_path(current_user)
      flash[:notice] = "Account settings saved."
    else
      if current_user.plan.update_attributes(params[:plan]) && current_user.plan.process_transaction
        current_user.plan.set_level
        current_user.plan.save
        redirect_to edit_user_path(current_user)
        flash[:notice] = "Plan upgraded to #{current_user.plan.render_plan_option}"
      else
        redirect_to edit_user_path(current_user)
        flash[:notice] = "Something's gone wrong! Try again, please."
      end
    end
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    
    @user.setup_portfolio_and_design
    @user.setup_plan
    @user.activate!
    success = @user && @user.save && @user.portfolio
    if success && @user.errors.empty?
      self.current_user = @user
      redirect_to root_path
      flash[:notice] = "Welcome to Weefolio, #{@user.login}!"
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
  
  def reset_password
    @page_title = "Weefolio - Change my Password"
    
    if request.post?
      user = User.find_by_email(params[:user][:email])
      if user && user.login == params[:user][:login]
        if user.update_attributes(:password => params[:user][:new_password], :password_confirmation => params[:user][:new_password_confirm])
          redirect_to login_path
          flash[:notice] = "Password changed. You can now login with your new password."
        else
          redirect_to forgot_password_path
          flash[:notice] = "Something went wrong. Please try again."
        end
      else
        flash[:notice] = "Bad login/email. Please try again."
      end
    end
  end
  
  # This would be less expensive as an AJAX action. 
  def switch_design_type
    @user = current_user
    if @user.design_type == 1
      @user.set_design_type(2)
    else
      @user.set_design_type(1)
    end
    @user.save
    redirect_to edit_user_design_path(@user, @user.design)
  end
  
  def close_account_confirm
  end
  
  def remove_account
    UserMailer.deliver_delete_account_message(current_user)
    current_user.delete
    redirect_to logout_path
  end
  
  def users_admin
    @users = User.find(:all)
  end
end
