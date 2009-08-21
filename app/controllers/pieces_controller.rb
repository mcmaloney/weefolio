class PiecesController < ApplicationController
  layout :choose_layout
  before_filter :authorize, :except => [:new, :create, :show, :edit, :update, :destroy]
  
  def new
    @page_title = "Weefolio :: New Piece"
    @portfolio = current_user.portfolio
    @piece  = @portfolio.pieces.new
  end
  
  def create
    @portfolio = current_user.portfolio
    @piece = @portfolio.pieces.create!(params[:piece])
    if @piece.save
      redirect_to edit_user_portfolio_path(current_user, @portfolio)
      if @piece.for_sale
        flash[:notice] = "Added '#{@piece.title}' to your Weefolio (for sale at #{@piece.display_price})"
      else
        flash[:notice] = "Added '#{@piece.title}' to your Weefolio"
      end
    end
  end

  def edit
    @portfolio = current_user.portfolio
    @piece = Piece.find(params[:id])
    @page_title = "Weefolio :: Edit '#{@piece.title}'"
  end
  
  def update
    @portfolio = current_user.portfolio
    @piece = Piece.find(params[:id])
    
    if @piece.update_attributes(params[:piece])
      redirect_to edit_user_portfolio_path(current_user)
      flash[:notice] = "Piece updated."
    end
  end
  
  def destroy
    @piece = Piece.find(params[:id])
    
    @piece.destroy
    if current_user.admin?
      redirect_to pieces_admin_path
      flash[:notice] = "'#{@piece.title}' deleted."
    else
      redirect_to edit_user_portfolio_path(current_user)
      flash[:notice] = "'#{@piece.title}' deleted."
    end
  end

  def show
    @piece = Piece.find(params[:id])
    @user = current_user
    @page_title = "#{@user.login} :: #{@piece.title}"
    @design = @user.design
    @portfolio = @user.portfolio
  end
  
  def pieces_admin
    @pieces = Piece.find(:all)
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
