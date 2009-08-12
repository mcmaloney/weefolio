class PortfoliosController < ApplicationController
  layout :choose_layout
  
  # This is what the world sees. (My Weefolio)
  def show
    @user = current_user
    @design = current_user.design
    @portfolio = current_user.portfolio
    @page_title = "Weefolio :: #{@user.login}"
  end
  
  # This is where you go when you want to manage the content of your Weefolio. (Portfolio)
  def edit 
    @user = current_user
    @design = current_user.design
    @portfolio = current_user.portfolio
    @page_title = "Weefolio :: Manage My Work"
  end
  
  # Send message action for the contact user form.
  def send_message
    @user = User.find(params[:id])
    @from = params[:from]
    @from_name = params[:name]
    @recip = @user.email
    @message = params[:message]
    UserMailer.deliver_user_message(@recip, @from, @from_name, @message)
    redirect_to user_portfolio_path(@user, @user.portfolio)
    flash[:notice] = "Message sent."
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