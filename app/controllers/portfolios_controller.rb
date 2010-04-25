class PortfoliosController < ApplicationController
  layout :choose_layout
  before_filter :login_required, :only => [:edit]
  before_filter :get_user_design_portfolio, :except => :show
  
  # This is what the world sees. (My Weefolio)
  def show
    @user = User.find_by_login(params[:login])
    @design = @user.design
    @portfolio = @user.portfolio
    @page_title = "Weefolio - #{@user.login}"
  end
  
  # This is where you go when you want to manage the content of your Weefolio. (Portfolio)
  def edit 
    @page_title = "Weefolio - Manage My Work"
  end
  
  # Send message action for the contact user form.
  def send_message
    if !params[:from].blank? && !params[:name].blank? && !params[:message].blank?
      UserMailer.deliver_user_message(@user.email, params[:from], params[:name], params[:message])
      redirect_to user_portfolio_path(@user.login)
      flash[:notice] = "Your <strong>message</strong> has been sent."
    else
      redirect_to user_portfolio_path(@user.login)
      flash[:notice] = "YOU MUST FILL IN NAME, EMAIL AND MESSAGE."
    end
  end
  
  protected
  
  def get_user_design_portfolio
    @user = User.find(params[:id], :include => [:design, :portfolio])
    @design = @user.design
    @portfolio = @user.portfolio
  end

  private
  
  def choose_layout
    if ['show'].include? action_name
      'weefolio'
    else
      'template'
    end
  end
end