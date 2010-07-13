require 'spec_helper'

describe ImageUploadsController do
  before(:each) do
    User.delete_all
    @user = Factory(:user)
    @user.setup
    login_as(@user)
    @user.portfolio.pieces << Factory(:piece)
  end
  
  describe "GET new" do
    it "should setup a new image upload" do
      get :new, :piece_id => @user.portfolio.pieces.first.id
      assigns['piece'].id.should == @user.portfolio.pieces.first.id
      assigns['image_upload'].should_not be_nil
    end
  end
  
  describe "GET edit" do
    it "should let me edit my image uploads" do
      @user.portfolio.pieces.first.image_uploads << Factory(:image_upload)
      get :edit, :piece_id => @user.portfolio.pieces.first.id, :id => @user.portfolio.pieces.first.image_uploads.first.id
      assigns['piece'].id.should == @user.portfolio.pieces.first.id
      assigns['image_upload'].should_not be_nil
    end
  end
  
  describe "GET index" do
    it "should show all the images for a given piece" do
      3.times do
        @user.portfolio.pieces.first.image_uploads << Factory(:image_upload)
      end
      get :index, :piece_id => @user.portfolio.pieces.first.id
      assigns['piece'].id.should == @user.portfolio.pieces.first.id
    end
  end
  
  describe "POST create" do
    it "should add an image to my piece" do
      post :create, :piece_id => @user.portfolio.pieces.first.id, :image_upload => { :image => "TEST" }
      assigns['piece'].id.should == @user.portfolio.pieces.first.id
      assigns['image_upload'].should_not be_nil
      response.should redirect_to(piece_image_uploads_path(@user.portfolio.pieces.first))
      flash[:notice].should include("Image added.")
    end
  end
  
  describe "PUT update" do
    it "should update the image with a new file" do
      @user.portfolio.pieces.first.image_uploads << Factory(:image_upload)
      put :update, :piece_id => @user.portfolio.pieces.first.id, :id => @user.portfolio.pieces.first.image_uploads.first.id, :image_upload => { :image => "TEST" }
      assigns['piece'].id.should == @user.portfolio.pieces.first.id
      assigns['image_upload'].should_not be_nil
      response.should redirect_to(piece_image_uploads_path(@user.portfolio.pieces.first))
      flash[:notice].should include("Image updated.")
    end
  end
  
  describe "DELETE destroy" do
    it "should delete an image upload" do
      @user.portfolio.pieces.first.image_uploads << Factory(:image_upload)
      delete :destroy, :piece_id => @user.portfolio.pieces.first.id, :id => @user.portfolio.pieces.first.image_uploads.first.id
      assigns['piece'].id.should == @user.portfolio.pieces.first.id
      assigns['image_upload'].should_not be_nil
      @user.portfolio.pieces.first.image_uploads.count.should == 0
      response.should redirect_to(piece_image_uploads_path(@user.portfolio.pieces.first))
      flash[:notice].should include("Image deleted.")
    end
  end
end
