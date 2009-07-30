class PortfoliosController < ApplicationController
  layout "template"
  
  # This is what the world sees. (My Weefolio)
  def show
    @page_title = "Weefolio"
    @user = current_user
    @portfolio = current_user.portfolio
  end
  
  # This is where you go when you want to manage the content of your Weefolio. (Portfolio)
  def edit 
    @page_title = "Weefolio :: Manage My Work"
    @user = current_user
    @portfolio = current_user.portfolio
  end
end
