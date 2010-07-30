class Admin::ThemeUploadsController < ApplicationController
  def index
    @theme_uploads = ThemeUpload.all
  end
end
