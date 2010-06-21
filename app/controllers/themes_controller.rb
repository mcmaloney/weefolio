class ThemesController < ApplicationController
  layout "template"
  
  def index
    @themes = Theme.all.paginate(:page => params[:page], :per_page => 9)
  end

end
