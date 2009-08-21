require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Piece do
  describe "for sale" do
    it "should display its price" do
      piece = Factory(:piece, :for_sale => true)
      piece.display_price.should == "$12.75"
    end
  end
  
  describe "images" do
    it "should have an array of images" do
      piece = Factory(:piece)
      piece.images.length.should == 5
    end
  end
end