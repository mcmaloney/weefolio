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
  
  it "should have up to 5 images" do
    @piece = Factory(:piece)
    @piece.images.should include(@piece.image_1, @piece.image_2, @piece.image_3, @piece.image_4, @piece.image_5)
  end
  
  it "should show the number of images being zero on create" do
    @piece = Factory(:piece)
    @piece.number_of_images.should == 0
  end
  
  it "should show one image if the size of the file is greater than zero" do
    @piece = Factory(:piece)
    @piece.image_1_file_size = 23.5
    @piece.number_of_images.should == 1
  end
end
