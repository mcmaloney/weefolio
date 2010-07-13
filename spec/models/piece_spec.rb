require 'spec_helper'

describe Piece do
  before(:each) do
    User.delete_all
    @user = Factory(:user)
    @user.setup
    @portfolio = @user.portfolio
    @design = @user.design
  end
  
  it "should should show the price if the piece is for sale" do
    @piece = Factory(:piece, :for_sale => true, :price => 25.55)
    @piece.display_price.should == "$25.55"
  end
  
  it "should not show the price if the piece is not listed for sale" do
    @piece = Factory(:piece, :for_sale => false, :price => 25.55)
    @piece.display_price.should be_nil
  end
  
  it "should show the max number of images for plan level 1" do
    @user.portfolio.pieces << Factory(:piece)
    @user.portfolio.pieces.first.max_images.should == 1
  end
  
  it "should show the max number of images for plan level 2" do
    @user.plan.update_attribute(:level, 2)
    @user.portfolio.pieces << Factory(:piece)
    @user.portfolio.pieces.first.max_images.should == 3
  end
  
  it "should show the max number of images for plan level 3" do
    @user.plan.update_attribute(:level, 3)
    @user.portfolio.pieces << Factory(:piece)
    @user.portfolio.pieces.first.max_images.should == 5
  end
  
  it "should allow me to add only 1 upload if my plan level is 1" do
    @user.portfolio.pieces << Factory(:piece)
    @user.portfolio.pieces.first.image_uploads << Factory(:image_upload)
    @user.portfolio.pieces.first.can_add_more_images?.should be_false
  end
  
  it "should allow me to add 3 uploads if my plan level is 2" do
    @user.plan.update_attribute(:level, 2)
    @user.portfolio.pieces << Factory(:piece)
    3.times do
      @user.portfolio.pieces.first.image_uploads << Factory(:image_upload)
    end
    @user.portfolio.pieces.first.can_add_more_images?.should be_false 
  end
  
  it "should allow me to add 5 uploads if my plan level is 3" do
    @user.plan.update_attribute(:level, 3)
    @user.portfolio.pieces << Factory(:piece)
    5.times do
      @user.portfolio.pieces.first.image_uploads << Factory(:image_upload)
    end
    @user.portfolio.pieces.first.can_add_more_images?.should be_false
  end
end
