class PortfoliosController < ApplicationController
  def show
    @user = current_user
    @portfolio = current_user.portfolio
  end
end
