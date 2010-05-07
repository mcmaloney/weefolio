require 'spec_helper'

describe Theme do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Theme.create!(@valid_attributes)
  end
end
