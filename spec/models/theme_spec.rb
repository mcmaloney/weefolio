require 'spec_helper'

describe Theme do
  before(:each) do
    @valid_attributes = {
      :directory_name => "value for directory_name",
      :template_filename => "value for template_filename",
      :design_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Theme.create!(@valid_attributes)
  end
end
