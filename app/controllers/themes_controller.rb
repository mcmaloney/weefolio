class ThemesController < ApplicationController
  layout "template"
  
  def index
    @themes = Theme.all.paginate(:page => params[:page], :per_page => 9)
  end
  
  def show
    
  end
  
  def install
    @theme = Theme.find(params[:id])
  end
end
