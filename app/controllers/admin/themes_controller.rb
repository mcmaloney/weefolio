class Admin::ThemesController < ApplicationController
  def index
    @themes = Theme.all.paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @theme = Theme.new(params[:theme])
  end
  
  def create
    @theme = Theme.new(params[:theme])
    if @theme.save
      redirect_to admin_themes_path
      flash[:notice] = "Theme info saved."
    else
      render :action => 'new'
    end
  end
  
  def edit
    @theme = Theme.find(params[:id])
  end
  
  def update
    @theme = Theme.find(params[:id])
    if @theme.update_attributes(params[:theme])
      redirect_to admin_themes_path
      flash[:notice] = "Theme info saved."
    else
      render :action => 'edit'
    end
  end

end
