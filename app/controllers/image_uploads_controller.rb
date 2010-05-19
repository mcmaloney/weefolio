class ImageUploadsController < ApplicationController
  layout 'template'
  before_filter :get_piece
  before_filter :init_image, :only => [:new, :create]
  before_filter :find_image, :only => [:edit, :update, :destroy]
  
  def new
  end
  
  def edit
  end
  
  def index
  end
  
  def create
    if @image_upload.save
      redirect_to piece_image_uploads_path(@piece)
      flash[:notice] = "Image added."
    else
      render :action => 'new'
      flash[:notice] = "There was a problem uploading this image. Please try again!"
    end
  end
  
  def update
    if @image_upload.update_attributes(params[:image_upload])
      redirect_to piece_image_uploads_path(@piece)
      flash[:notice] = "Image updated."
    else
      render :action => 'edit'
      flash[:notice] = "There was a problem updating this image. Please try again!"
    end
  end
  
  def destroy
    @image_upload.destroy
    redirect_to piece_image_uploads_path(@piece)
    flash[:notice] = "Image deleted."
  end
  
  protected
  
  def get_piece
    @piece = current_user.portfolio.pieces.find(params[:piece_id])
  end
  
  def init_image
    @image_upload = @piece.image_uploads.new(params[:image_upload])
  end
  
  def find_image
    @image_upload = ImageUpload.find(params[:id])
  end
end
