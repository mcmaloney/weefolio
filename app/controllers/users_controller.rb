class UsersController < ApplicationController
  layout 'template'
  
  def new
    @page_title = "Sign Up for Weefolio!"
    @user = User.new
  end
  
  def edit
    @page_title = "Weefolio :: My Account"
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_path
      flash[:notice] = "Account info updated."
    end
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    
    # Give the user a portfolio
    @user.make_portfolio
    # And a design editor **** THESE SHOULD BE REFACTORED INTO A SETUP METHOD SO THEY HAPPEN TOGETHER
    @user.make_design_editor
    
    @user.activate!
    success = @user && @user.save && @user.portfolio
    if success && @user.errors.empty?
      self.current_user = @user
      redirect_to root_path
      flash[:notice] = "Welcome to Weefolio, #{@user.login}!"
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
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
end
