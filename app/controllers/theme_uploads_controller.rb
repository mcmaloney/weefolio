class ThemeUploadsController < ApplicationController
  layout "template"
  
  before_filter :login_required
  
  def new
    @theme_upload = ThemeUpload.new(params[:theme_upload])
  end
  
  def create
    @theme_upload = ThemeUpload.new(params[:theme_upload])
    if @theme_upload.save
      redirect_to themes_path
      flash[:notice] = "Thanks for submitting a theme! We'll take a look and add it soon."
    else
      render :action => 'new'
    end
  end

end
