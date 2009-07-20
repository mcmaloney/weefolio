require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Portfolio do
  describe "being created" do
    it "should have no pieces in it" do
      portfolio = Portfolio.new
      portfolio.pieces.length.should == 0
    end
  end
end
