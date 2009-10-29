class PortfoliosController < ApplicationController
  layout :choose_layout
  before_filter :get_user_design_portfolio, :except => [:send_message]
  
  # This is what the world sees. (My Weefolio)
  def show
    @page_title = "Weefolio :: #{@user.login}"
  end
  
  # This is where you go when you want to manage the content of your Weefolio. (Portfolio)
  def edit 
    @page_title = "Weefolio :: Manage My Work"
  end
  
  # Send message action for the contact user form.
  def send_message
    @user = User.find(params[:id])
    @from = params[:from]
    @from_name = params[:name]
    @recip = @user.email
    @message = params[:message]
    UserMailer.send_later :deliver_user_message, @recip, @from, @from_name, @message
    redirect_to user_portfolio_path(@user, @user.portfolio)
    flash[:notice] = "Message sent."
  end
  
  protected
  
  def get_user_design_portfolio
    @user = current_user
    @design = current_user.design
    @portfolio = current_user.portfolio
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