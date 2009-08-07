require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Design do
  before(:each) do
    @user = Factory(:user)
    @user.make_design_editor
  end
  
  describe "being created" do
    it "should read design type from the user" do
      @user.design.design_type.should == 1
    end
  end
  
  describe "render boolean values to strings" do
    it "should display the sans-serif state as a string" do
      @design = @user.design
      @design.render_serif(@design.text_serif).should == "sans-serif"
    end
    
    it "should display the serif state as a string" do
      @design = @user.design
      @design.render_serif(@design.title_serif).should == "serif"
    end
    
    it "should display the italic state as a string" do
      @design = @user.design
      @design.render_italic(@design.tagline_italic).should == "normal"
    end
    
    it "should display the bold state as a string" do
      @design = @user.design
      @design.render_bold(@design.tagline_bold).should == "normal"
    end
  end
end
