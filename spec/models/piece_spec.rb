require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Piece do
  describe "for sale" do
    it "should display its price" do
      piece = Factory(:piece, :for_sale => true)
      piece.display_price.should == "$12.75"
    end
  end
end
