class Admin::ThemeUploadsController < ApplicationController
  def index
    @theme_uploads = ThemeUpload.all
  end
  
  def show
    @theme_upload = ThemeUpload.find(params[:id])
  end
end
