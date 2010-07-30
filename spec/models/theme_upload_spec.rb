require 'spec_helper'

describe ThemeUpload do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :source_code => "value for source_code"
    }
  end

  it "should create a new instance given valid attributes" do
    ThemeUpload.create!(@valid_attributes)
  end
end
