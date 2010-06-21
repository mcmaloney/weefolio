require 'spec_helper'

describe Portfolio do
  before(:each) do
    User.delete_all
    @user = Factory(:user)
    @user.setup
    @portfolio = @user.portfolio
  end
  
  it "should have an account tier from its user" do
    @portfolio.account_tier.should == @user.plan.level
  end
  
  it "should allow me only 5 pieces if I have a level 1 account" do
    @portfolio.max_pieces.should == 5
  end
  
  it "should allow me 20 pieces if I have a level 2 account" do
    @user.plan.update_attribute(:level, 2)
    @portfolio.max_pieces.should == 20
  end
  
  it "should allow me unlimited pieces if I have a level 3 account" do
    @user.plan.update_attribute(:level, 3)
    @portfolio.max_pieces.should be_nil
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
  
  it "should allow me to add unlimited pieces if I have a level 3 account" do
    @user.plan.update_attribute(:level, 3)
    50.times do
      @portfolio.pieces << Factory(:piece)
    end
    @portfolio.can_add_more?.should be_true
  end
  
  it "should tell me the max number of pieces if asked" do
    Portfolio.max_pieces_for(1).should == 5
    Portfolio.max_pieces_for(2).should == 20
    Portfolio.max_pieces_for(3).should == nil
  end
end
