class PiecesController < ApplicationController
  def new
    @portfolio = current_user.portfolio
    @piece  = @portfolio.pieces.new
  end
  
  def create
    @portfolio = current_user.portfolio
    @piece = @portfolio.pieces.create!(params[:piece])
    if @piece.save
      redirect_to user_portfolio_path(current_user, @portfolio)
      flash[:notice] = "Added '#{@piece.title}' to your Weefolio"
    end
  end

  def edit
  end

  def show
  end

end
