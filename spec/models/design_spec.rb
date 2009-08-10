require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Design do
  before(:each) do
    @user = Factory(:user)
    @user.make_design_editor
    @design = @user.design
  end
  
  describe "being created" do
    it "should read design type from the user" do
      @user.design.design_type.should == 1
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
