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
    
    it "should render verdana" do
      @user.design.update_attribute(:font_family, "Verdana")
      @user.design.render_font_family.should == "Verdana, 'Verdana Ref', sans-serif"
    end
    
    it "should render lucida grande" do
      @user.design.update_attribute(:font_family, "Lucida Grande")
      @user.design.render_font_family.should == "'Lucida Grande', Arial, sans-serif"
    end
    
    it "should render arial" do
      @user.design.update_attribute(:font_family, "Arial")
      @user.design.render_font_family.should == "Arial, sans-serif"
    end
    
    it "should render helvetica" do
      @user.design.update_attribute(:font_family, "Helvetica")
      @user.design.render_font_family.should == "Helvetica, Arial, sans-serif"
    end
    
    it "should render times new roman" do
      @user.design.update_attribute(:font_family, "Times New Roman")
      @user.design.render_font_family.should == "Times, 'Times New Roman', serif"
    end
    
    it "should render courier" do
      @user.design.update_attribute(:font_family, "Courier")
      @user.design.render_font_family.should == "'Courier New', Courier, monospace"
    end
    
    it "should render georgia" do
      @user.design.update_attribute(:font_family, "Georgia")
      @user.design.render_font_family.should == "Georgia, 'Times New Roman', serif"
    end
    
    it "should render trebuchet ms" do
      @user.design.update_attribute(:font_family, "Trebuchet MS")
      @user.design.render_font_family.should == "'Trebuchet MS', Verdana, 'Verdana Ref', sans-serif"
    end
  end
end
