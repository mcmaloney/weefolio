require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Design do
  describe "being created" do
    it "should read design type from the user" do
      user = Factory(:user)
      user.make_design_editor
      user.design.design_type.should == 1
    end
  end
end
