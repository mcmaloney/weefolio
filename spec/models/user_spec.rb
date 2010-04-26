require 'spec_helper'

describe User do
  before(:each) do
    User.delete_all
    @user = Factory(:user)
    @user.setup
  end
  
  describe "setting up the user" do
    it "should have a portfolio" do
      @user.portfolio.should_not be_nil
    end
    
    it "should have a design" do
      @user.design.should_not be_nil
    end
    
    it "should be activated" do
      @user.active?.should be_true
    end
    
    it "should have been activated recently" do
      @user.recently_activated?.should be_true
    end
    
    it "should have a plan, level 1" do
      @user.plan.level.should == 1
    end
    
    it "should have all the associated stuff" do
      @user.has_associated.should be_true
    end
    
    it "should not be an admin" do
      @user.admin?.should be_false
    end
    
    it "should not have an activation code if it's active" do
      @user.activation_code.should be_nil
    end
    
    it "should have several card types" do
      @user.card_types[0].should == "Visa"
      @user.card_types[1].should == "Mastercard"
      @user.card_types[2].should == "Discover"
      @user.card_types[3].should == "American Express"
    end
  end
  
  describe "logging in with authentication" do
    it "should authenticate a user" do
      User.authenticate(@user.login, @user.password).should_not be_nil
    end
  end
  
  describe "searching for users based on login" do
    it "should return a number of users based on a search parameter" do
      User.search(@user.login, "1").should_not be_nil
    end
  end
  
  describe "changing tier and stuff" do 
    it "should change the account tier" do
      @user.change_tier(2)
      @user.account_tier.should == 2
    end
    
    it "should show the account tier in a readable way" do
      @user.render_account_tier.should == "Basic"
    end
    
    it "should show the account tier in a readable way if I change the tier" do
      @user.plan.level = 2
      @user.render_account_tier.should == "Plus ($2.99/Month)"
    end
    
    it "should show the account tier in a readable way if I change the tier... again" do
      @user.plan.level = 3
      @user.render_account_tier.should == "Pro ($4.99/Month)"
    end
    
    it "should update the account tier based on the plan level" do
      @user.plan.level = 2
      @user.update_account_tier(@user.plan.level)
      @user.account_tier.should == 2
    end
    
    # This only returns true with a transaction present. For now, we'll say it has to be false without that. Still means it's working...
    it "should check if the user, plan and transaction have all been updated successfully" do
      @user.plan.update_attribute(:level, 2)
      @user.update_self_and_plan({:login => @user.login}, {:level => @user.plan.level}).should be_false
    end
    
    # If we're changing back to level 1, we have to skip te validations.
    it "should not checl for a transaction being process for level 1" do
      @user.update_self_and_plan({:login => @user.login}, {:level => @user.plan.level}).should be_true
    end
  end
  
  describe "small stuff in the user model for design" do 
    it "should change and set the design type" do
      @user.set_design_type(2)
      @user.design_type.should == 2
    end
  end
end
