require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Design do
  before(:each) do
    @user = Factory(:user)
    @user.setup_portfolio_and_design
    @design = @user.design
  end
  
  describe "being created" do
    it "should read design type from the user" do
      @design.design_type.should == 1
    end
    
    it "should have a layout type of 1" do
      @design.layout_type.should == 1
    end
  end
  
  describe "layout types" do
    it "should have a grid layout" do
      @user.design.render_layout_type.should == "grid"
    end
    
    it "should have a list layout" do
      @design.set_layout_type(2)
      @design.render_layout_type.should == "list"
    end
  end
  
  describe "change layout type" do
    it "should change layout type from 1 to 2" do
      @design.set_layout_type(2)
      @design.layout_type.should == 2
    end
    
    it "should change layout from 2 to 1" do
      @design.set_layout_type(2)
      @design.set_layout_type(1)
      @design.layout_type.should == 1
    end
  end
  
  describe "render boolean values to strings" do
    it "should display the sans-serif state as a string" do
      @design.render_serif(@design.text_serif).should == "sans-serif"
    end
    
    it "should display the serif state as a string" do
      @design.render_serif(@design.title_serif).should == "serif"
    end
    
    it "should display the italic state as a string" do
      @design.render_italic(@design.tagline_italic).should == "normal"
    end
    
    it "should display the bold state as a string" do
      @design.render_bold(@design.tagline_bold).should == "normal"
    end
  end
  
  describe "render integer values to strings" do
    it "should render a font size to a string" do
      @design.render_font_size(@design.text_size).should == "12px"
    end
  end
end
