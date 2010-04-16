require 'spec_helper'

describe Portfolio do
  before(:each) do
    User.delete_all
    @user = Factory(:user)
    @user.setup
    @portfolio = @user.portfolio
  end
  
  it "should have a permalink" do
    @portfolio.to_param.should == @portfolio.permalink
  end
  
  it "should have an account tier from its user" do
    @portfolio.account_tier.should == @user.account_tier
  end
  
  it "should allow me only 5 pieces if I have a level 1 account" do
    @portfolio.max_pieces.should == 5
  end
  
  it "should allow me 15 pieces if I have a level 2 account" do
    @user.plan.level = 2
    @user.update_account_tier(@user.plan.level)
    @portfolio.max_pieces.should == 15
  end
  
  it "should allow me 25 pieces if I have a level 2 account" do
    @user.plan.level = 3
    @user.update_account_tier(@user.plan.level)
    @portfolio.max_pieces.should == 25
  end
  
  it "should allow me to add more pieces if I have not exceed the max for my account tier" do
    @portfolio.can_add_more?.should be_true
  end
  
  it "should not allow me to add more pieces if I have exceed the max for my account tier" do
    5.times do
      @portfolio.pieces << Factory(:piece)
    end
    @portfolio.can_add_more?.should be_false
  end
end
