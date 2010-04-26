require 'spec_helper'

describe Plan do
  
  before(:each) do
    @plan_level_1 = Factory(:plan, :level => 1)
                             
    @plan_level_2 = Factory(:plan, :level => 2)
                             
    @plan_level_3 = Factory(:plan, :level => 3)
                    
    @plan_bad_card_num = Plan.new(:card_number => "12345", 
                                  :card_verification => "123", 
                                  :card_expiration_month => "4", 
                                  :card_expiration_year => "2012",
                                  :card_type => "Visa",
                                  :billing_first_name => Faker::Name.first_name,
                                  :billing_last_name => Faker::Name.last_name,
                                  :billing_address => Faker::Address.street_address,
                                  :billing_city => Faker::Address.city,
                                  :billing_state => Faker::Address.us_state,
                                  :billing_postal_code => Faker::Address.zip_code)
                                  
    @plan_bad_exp_year =  Plan.new(:card_number => "4007000000027", 
                                   :card_verification => "123", 
                                   :card_expiration_month => "4", 
                                   :card_expiration_year => "2009",
                                   :card_type => "Visa",
                                   :billing_first_name => Faker::Name.first_name,
                                   :billing_last_name => Faker::Name.last_name,
                                   :billing_address => Faker::Address.street_address,
                                   :billing_city => Faker::Address.city,
                                   :billing_state => Faker::Address.us_state,
                                   :billing_postal_code => Faker::Address.zip_code)
  end
  it "should make an authnet credit card" do
    @plan_level_2.authnet_credit_card.should_not be_nil
  end
  
  it "should have a valid credit card" do
    @plan_level_2.valid_cc?.should be_true
  end
  
  it "should have no status if a transaction has not been processed" do
    @plan_level_2.status.should == :none
  end
  
  it "should be able to set a status" do
    @plan_level_2.status = :none
    @plan_level_2.status.should == :none
  end
  
  it "should be invalid without a real credit card number" do
    @plan_bad_card_num.has_valid_credit_card
    @plan_bad_card_num.errors[:base].should include("Credit card invalid – please verify that your billing information matches your credit card statement and verify your credit card account number and security code.")
  end
  
  it "should be invalid without a correct expiration year" do
    @plan_bad_exp_year.has_valid_credit_card
    @plan_bad_exp_year.errors[:base].should include("Credit card invalid – please verify that your billing information matches your credit card statement and verify your credit card account number and security code.")
  end
  
  it "should populate the amount in cents for level 1" do
    @plan_level_1.populate_amount_in_cents.should == 0
  end
  
  it "should populate the amount in cents for level 2" do
    @plan_level_2.populate_amount_in_cents.should == 299
  end
  
  it "should populate the amount in cents for level 3" do
    @plan_level_3.populate_amount_in_cents.should == 499
  end
  
  it "should process a transaction with success" do
    @plan_level_2.process_transaction.should be_true
  end
  
  it "should set the payment status as charged if we get a successful response from the gateway" do
    @plan_level_2.process_transaction
    @plan_level_2.status.should == :charged
  end
  
  it "should process a transaction with failure if we've got some mickey mouse info" do
    @plan_bad_card_num.process_transaction.should be_false
    @plan_bad_exp_year.process_transaction.should be_false
  end
  
  it "should set the payment status to failed if we get a bad response from the gateway" do
    # Gotta figure out a way to get the gateway to give a failure response to get this to pass.
  end
  
  it "should set the payment status as failed if we have invalid info" do
    @plan_bad_card_num.process_transaction
    @plan_bad_card_num.status.should == :failed
  end
  
  it "should prevent me from downgrading if I have too many pieces" do
    User.delete_all
    @user = Factory(:user)
    @user.setup
    @user.plan.update_attribute(:level, 2)
    6.times do
      @user.portfolio.pieces << Factory(:piece)
    end
    @user.plan.can_downgrade_to(1).should be_false
  end
  
  it "should let me downgrade if I don't have more pieces than I'm allowed" do
    User.delete_all
    @user = Factory(:user)
    @user.setup
    @user.plan.update_attribute(:level, 2)
    3.times do
      @user.portfolio.pieces << Factory(:piece)
    end
    @user.plan.can_downgrade_to(1).should be_true
  end
  
  it "should tell me how many pieces I have to delete to downgrade" do
    User.delete_all
    @user = Factory(:user)
    @user.setup
    @user.plan.update_attribute(:level, 2)
    8.times do
      @user.portfolio.pieces << Factory(:piece)
    end
    @user.plan.delete_pieces_for(1).should == 3
  end
end
