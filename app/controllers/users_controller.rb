class UsersController < ApplicationController
  layout 'template'
  
  before_filter :authorize, :only => [:users_admin]
  before_filter :init_user, :only => [:new, :create]
  before_filter :get_current_user, :except => [:new, :create, :reset_password]
  
  def index
    @users = User.search(params[:search])
  end
  
  def new
    @page_title = "Weefolio - Pricing &amp; Sign Up"
  end
  
  def edit
    @page_title = "Weefolio - My Account"
    @us_states = US_STATES.collect{|s| [s[0], s[1]]}
  end
  
  def update
    if params[:plan][:level] == @user.plan.level.to_s
      if @user.update_attributes(params[:user])
        redirect_to edit_user_path(@user)
        flash[:notice] = "Account settings saved."
      end
    else
      if @user.update_self_and_plan(params[:user], params[:plan])
        @user.update_account_tier(params[:plan][:level])
        redirect_to edit_user_path(@user)
        flash[:notice] = "Plan changed to #{@user.render_account_tier}"
      else
        redirect_to edit_user_path(@user)
        flash[:notice] = "Something's gone wrong! Try again, please."
      end
    end
  end
 
  def create
    logout_keeping_session!
    
    @user.setup
    success = @user && @user.save && @user.has_associated
    if success && @user.errors.empty?
      self.current_user = @user
      redirect_to root_path
      flash[:notice] = "Welcome to Weefolio, #{@user.login}!"
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again."
      render :action => 'new'
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
    UserMailer.deliver_delete_account_message(@user)
    @user.delete
    redirect_to logout_path
  end
  
  def users_admin
    @users = User.find(:all)
  end
  
  protected
  
  def init_user
    @user = User.new(params[:user])
  end
  
  def get_current_user
    @user = User.find_by_login(current_user.login, :include => [:plan, :portfolio, :design])
  end
end
