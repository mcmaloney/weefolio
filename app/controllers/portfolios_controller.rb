class PortfoliosController < ApplicationController
  layout :choose_layout
  before_filter :get_user_design_portfolio
  
  # This is what the world sees. (My Weefolio)
  def show
    @page_title = "Weefolio - #{@user.login}"
  end
  
  # This is where you go when you want to manage the content of your Weefolio. (Portfolio)
  def edit 
    @page_title = "Weefolio - Manage My Work"
  end
  
  # Send message action for the contact user form.
  def send_message
    UserMailer.send_later :deliver_user_message, User.find(params[:id]).email, params[:from], params[:from_name], params[:message]
    redirect_to user_portfolio_path(@user, @user.portfolio)
    flash[:notice] = "Your <strong>message</strong> has been sent."
  end
  
  protected
  
  def get_user_design_portfolio
    @user = User.find(params[:user_id])
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