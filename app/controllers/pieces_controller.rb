class PiecesController < ApplicationController
  layout :choose_layout
  before_filter :authorize, :only => [:pieces_admin]
  before_filter :get_portfolio, :except => [:destroy, :pieces_admin]
  before_filter :init_piece, :only => [:new, :create]
  before_filter :find_piece, :only => [:show, :edit, :update, :destroy]
  before_filter :get_service_types, :only => [:new, :edit]
  
  def new
    @page_title = "Weefolio - Add New Work"
  end
  
  def create
    if @piece.save
      redirect_to edit_user_portfolio_path(@user, @portfolio)
      if @piece.for_sale
        flash[:notice] = "<strong>'#{@piece.title}'</strong> has been added to your Weefolio (for sale at #{@piece.display_price})"
      else
        flash[:notice] = "<strong>'#{@piece.title}'</strong> has been added to your Weefolio"
      end
    else
      redirect_to edit_user_portfolio_path(@user, @portfolio)
      flash[:notice] = "Couldn't upload that piece. Please ty again!"
    end
  end

  def edit
    @page_title = "Weefolio - Edit '#{@piece.title}'"
  end
  
  def update
    if @piece.update_attributes(params[:piece])
      redirect_to edit_user_portfolio_path(@user)
      flash[:notice] = "Piece updated."
    end
  end
  
  def destroy
    @piece.destroy
    if @user.admin?
      redirect_to pieces_admin_path
      flash[:notice] = "'#{@piece.title}' has been <strong>deleted</strong>."
    else
      redirect_to edit_user_portfolio_path(@user)
      flash[:notice] = "'#{@piece.title}' has been <strong>deleted</strong>."
    end
  end

  def show
    @page_title = "#{@user.login} - #{@piece.title}"
    @design = @user.design
  end
  
  def sort
    params[:pieces].each_with_index do |id, index|
      Piece.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
  def pieces_admin
    @pieces = Piece.find(:all)
  end
  
  protected
  
  def get_portfolio
    @user = User.find_by_login(params[:portfolio_id], :include => [:portfolio])
    @portfolio = @user.portfolio
  end
  
  def init_piece
    @piece = @portfolio.pieces.new(params[:piece])
  end
  
  def find_piece
    @user = User.find_by_login(params[:portfolio_id], :include => [:pieces])
    @piece = @user.pieces.find(params[:id])
  end
  
  def get_service_types
    @service_types = Piece::SERVICE_TYPES
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
