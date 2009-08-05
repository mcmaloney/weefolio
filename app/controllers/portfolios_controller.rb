class PortfoliosController < ApplicationController
  layout :choose_layout
  
  # This is what the world sees. (My Weefolio)
  def show
    @user = current_user
    @portfolio = current_user.portfolio
    @design = current_user.design
    @page_title = "Weefolio :: #{@user.login}"
  end
  
  # This is where you go when you want to manage the content of your Weefolio. (Portfolio)
  def edit 
    @user = current_user
    @portfolio = current_user.portfolio
    @page_title = "Weefolio :: Manage My Work"
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