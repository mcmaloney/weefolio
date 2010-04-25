require 'spec_helper'

describe Design do
  before(:each) do
    User.delete_all
    Design.delete_all
    @user = Factory(:user)
    @user.setup
    @design = @user.design
  end
  
  describe "setting up the design for a user" do  
    it "should have a design type" do
      @design.design_type.should == @user.design_type
    end
    
    it "should set the layout type" do
      @user.design.set_layout_type(2)
      @user.design.layout_type.should == 2
    end
    
    it "should have user_html" do
      @design.user_html.should_not be_nil
    end
    
    it "should not have erb in the un-parsed html" do
      @design.user_html.should_not include("<%=")
    end
  end
  
  describe "rendering CSS stuff from the model" do
    it "should render the layout type as grid" do
      @user.design.render_layout_type.should == "grid"
    end
    
    it "should render the layout type as list" do
      @user.design.set_layout_type(2)
      @user.design.render_layout_type.should == "list"
    end
    
    it "should have font sizes" do
      @user.design.font_sizes.should include(8, 10, 11, 12, 14, 16, 18, 20, 22, 24)
    end
    
    it "should have font families" do
      @user.design.font_families.should include("Arial", "Helvetica", "Times New Roman", "Courier", "Georgia", "Trebuchet MS", "Verdana")
    end
    
    it "should render a color as is if there's a # sign in it already" do
      @user.design.render_color("#FFF").should == "#FFF"
    end
    
    it "should add a a # to the color if there isn't one" do
      @user.design.render_color("FFF").should == "#FFF"
    end
  end
end
