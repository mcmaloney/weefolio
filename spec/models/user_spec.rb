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
    
    it "should be activated on creation" do
      @user.activate!
      @user.active?.should be_true
    end
  end
end
