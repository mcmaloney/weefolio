class PortfoliosController < ApplicationController
  layout "template"
  
  # This is what the world sees. (My Weefolio)
  def show
    @user = current_user
    @portfolio = current_user.portfolio
    @page_title = "Weefolio"
  end
  
  # This is where you go when you want to manage the content of your Weefolio. (Portfolio)
  def edit 
    @user = current_user
    @portfolio = current_user.portfolio
    @page_title = "Weefolio :: Manage My Work"
  end
end
