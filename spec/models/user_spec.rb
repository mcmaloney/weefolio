require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  describe "being created" do
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should have account tier 1" do
      @user.account_tier.should == 1
    end
    
    it "should have a portfolio" do
      @user.make_portfolio
      @user.portfolio.should be_true
    end
    
    it "should have a design" do
      @user.make_design_editor
      @user.design.should be_true
    end
    
    it "should be activated on creation" do
      @user.activate!
      @user.active?.should be_true
    end
    
    it "should have no pieces" do
      @user.pieces.length.should == 0
    end
    
    it "should have a space for a photo" do
      @user.photo.should be_true
    end
    
    it "should have layout type 1" do
      @user.layout_type.should == 1
    end
  end
  
  describe "change layout type" do
    it "should change layout type from 1 to 2" do
      user = Factory(:user)
      user.set_layout_type(2)
      user.layout_type.should == 2
    end
    
    it "should change layout from 2 to 1" do
      user = Factory(:user, :layout_type => 2)
      user.set_layout_type(1)
      user.layout_type.should == 1
    end
  end
    
  
  describe "being displayed" do
    it "should prompt if some info is blank" do
      user = Factory(:user, :tag_line => nil, :about_me => nil)
      user.has_blank_info.should be_true
    end
  end
  
  describe "account tier upgrades" do
    it "should upgrade to level two" do
      user = Factory(:user)
      user.change_tier(2)
      user.account_tier.should == 2
    end
  end
end
