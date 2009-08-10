require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Portfolio do 
  describe "being created" do
    before(:each) do
      @user = Factory(:user)
      @user.make_portfolio
    end
     
    it "should have no pieces in it" do
      @user.portfolio.pieces.length.should == 0
    end
  end

  describe "account tier 1" do
    before(:each) do
      @user = Factory(:user)
      @user.make_portfolio
    end
    
    it "should read the tier from the user" do
      @user.portfolio.account_tier.should == 1
    end
    
    it "should allow up to 5 pieces to be created" do
      @user.portfolio.max_pieces.should == 5
    end
    
    it "should prohibit the user from adding more then 5 pieces" do
      5.times do
        piece = Factory(:piece)
        @user.portfolio.pieces << piece
      end
      @user.portfolio.can_add_more?.should be_false
    end
  end
  
  describe "account tier 2" do
    before(:each) do
      @user = Factory(:user, :account_tier => 2)
      @user.make_portfolio
    end
    
    it "should read the tier from the user" do
      @user.portfolio.account_tier.should == 2
    end
    
    it "should allow up to 15 pieces to be created" do
      @user.portfolio.max_pieces.should == 15
    end
    
    it "should prohibit the user from adding more then 15 pieces" do
      15.times do
        piece = Factory(:piece)
        @user.portfolio.pieces << piece
      end
      @user.portfolio.can_add_more?.should be_false
    end
  end
  
  describe "account tier 3" do
    before(:each) do
      @user = Factory(:user, :account_tier => 3)
      @user.make_portfolio
    end
    
    it "should read the tier from the user" do
      @user.portfolio.account_tier.should == 3
    end
    
    it "should allow up to 25 pieces to be created" do
      @user.portfolio.max_pieces.should == 25
    end
    
    it "should prohibit the user from adding more then 25 pieces" do
      25.times do
        piece = Factory(:piece)
        @user.portfolio.pieces << piece
      end
      @user.portfolio.can_add_more?.should be_false
    end
  end
      
end
