class PiecesController < ApplicationController
  layout 'template'
  before_filter :login_required, :except => [:show]
  before_filter :set_user_and_portfolio
  before_filter :get_service_types, :only => [:new, :edit]
  
  def new
    @page_title = "Weefolio - Add New Work"
    @piece = current_user.portfolio.pieces.new(params[:piece])
  end
  
  def create
    @piece = current_user.portfolio.pieces.new(params[:piece])
    if @piece.save
      redirect_to new_piece_image_upload_path(@piece)
      if @piece.for_sale
        flash[:notice] = "<strong>'#{@piece.title}'</strong> has been added to your Weefolio (for sale at #{@piece.display_price})"
      else
        flash[:notice] = "<strong>'#{@piece.title}'</strong> has been added to your Weefolio"
      end
    else
      redirect_to edit_user_portfolio_path(current_user, current_user.portfolio)
      flash[:notice] = "Couldn't upload that piece. Please ty again!"
    end
  end

  def edit
    @piece = Piece.find(params[:id])
    @page_title = "Weefolio - Edit '#{@piece.title}'"
  end
  
  def update
    @piece = Piece.find(params[:id])
    if @piece.update_attributes(params[:piece])
      redirect_to edit_user_portfolio_path(current_user, current_user.portfolio)
      flash[:notice] = "Piece updated."
    end
  end
  
  def destroy
    @piece = Piece.find(params[:id])
    @piece.destroy
    redirect_to edit_user_portfolio_path(current_user, current_user.portfolio)
    flash[:notice] = "'#{@piece.title}' has been <strong>deleted</strong>."
  end
  
  def sort
    params[:pieces].each_with_index do |id, index|
      Piece.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  protected
  
  def set_user_and_portfolio
    @user = current_user
    @portfolio = @user.portfolio
  end
  
  def get_service_types
    @service_types = Piece::SERVICE_TYPES
  end
  
end
