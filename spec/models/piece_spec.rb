require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Piece do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :description => "value for description",
      :price => 9.99,
      :for_sale => false,
      :portfolio_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Piece.create!(@valid_attributes)
  end
end
