require 'spec_helper'

describe UserMailer do
  describe "user to user message" do
    before(:each) do
      @recip = Faker::Internet.email
      @from = Faker::Internet.email
      @from_name = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
      @message = Faker::Lorem.paragraph
      @email = UserMailer.create_user_message(@recip, @from, @from_name, @message)
    end
    
    it "should deliver the message to the recipient" do
      @email.should deliver_to(@recip)
    end
    
    it "should contain the message we wrote" do
      @email.should have_text(@message)
    end
    
    it "should be from the sender" do
      @email.should deliver_from(@from)
    end
    
    it "should show the sender's username in the subject" do
      @email.should have_subject("Message from Weefolio User #{@from_name}")
    end
  end
  
  describe "delete account message" do
    before(:each) do
      User.delete_all
      @user = Factory(:user)
      @email = UserMailer.create_delete_account_message(@user)
    end
    
    it "should deliver to the WEEFOLIO_ADMINS" do
      @email.should deliver_to(UserMailer::WEEFOLIO_ADMINS)
    end
    
    it "should be from WEEFOLIO SYSTEM" do
      @email.should deliver_from(UserMailer::WEEFOLIO_SYSTEM)
    end
    
    it "should have a subject showing us that it's about deleting an account" do
      @email.should have_subject("DELETE USER ACCOUNT REQUEST")
    end
    
    it "should show the username and email of the user requesting deletion" do
      @email.should have_text("The following user would like his/her account destroyed: #{@user.login} #{@user.email}")
    end
  end
end
