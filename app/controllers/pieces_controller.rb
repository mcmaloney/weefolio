class PiecesController < ApplicationController
  layout :choose_layout
  before_filter :authorize, :only => [:pieces_admin]
  before_filter :get_portfolio, :except => [:destroy, :pieces_admin]
  before_filter :init_piece, :only => [:new, :create]
  before_filter :find_piece, :only => [:show, :edit, :update, :destroy]
  
  def new
    @page_title = "Weefolio :: Add New Work"
  end
  
  def create
    if @piece.save
      redirect_to edit_user_portfolio_path(current_user, @portfolio)
      if @piece.for_sale
        flash[:notice] = "<strong>'#{@piece.title}'</strong> has been added to your Weefolio (for sale at #{@piece.display_price})"
      else
        flash[:notice] = "<strong>'#{@piece.title}'</strong> has been added to your Weefolio"
      end
    end
  end

  def edit
    @page_title = "Weefolio :: Edit '#{@piece.title}'"
  end
  
  def update
    if @piece.update_attributes(params[:piece])
      redirect_to edit_user_portfolio_path(current_user)
      flash[:notice] = "Piece updated."
    end
  end
  
  def destroy
    @piece.destroy
    if current_user.admin?
      redirect_to pieces_admin_path
      flash[:notice] = "'#{@piece.title}' has been <strong>deleted</strong>."
    else
      redirect_to edit_user_portfolio_path(current_user)
      flash[:notice] = "'#{@piece.title}' has been <strong>deleted</strong>."
    end
  end

  def show
    @user = current_user
    @page_title = "#{@user.login} :: #{@piece.title}"
    @design = @user.design
  end
  
  def pieces_admin
    @pieces = Piece.find(:all)
  end
  
  protected
  
  def get_portfolio
    @portfolio = current_user.portfolio
  end
  
  def init_piece
    @piece = @portfolio.pieces.new(params[:piece])
  end
  
  def find_piece
    if current_user.admin?
      @piece = Piece.find(params[:id])
    else
      @piece = current_user.pieces.find(params[:id])
    end
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
