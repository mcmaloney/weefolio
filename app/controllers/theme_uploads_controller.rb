class ThemeUploadsController < ApplicationController
  layout "template"
  
  def new
    @theme_upload = ThemeUpload.new(params[:theme_upload])
  end
  
  def create
    @theme_upload = ThemeUpload.new(params[:theme_upload])
    if @theme_upload.save
      redirect to themes_path
      flash[:notice] = "Thanks for submitting a theme! We'll take a look and add it soon."
    else
      render :action => 'new'
    end
  end

end
