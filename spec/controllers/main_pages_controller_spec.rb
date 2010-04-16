require 'spec_helper'

describe MainPagesController do
  before(:each) do
    User.delete_all
    @user = Factory(:user)
    @user.setup
    login_as(@user)
  end
  
  describe "GET home" do
    it "should show the homepage" do
      get :home
      assigns['page_title'].should_not be_nil
      response.should be_success
    end
  end
  
  describe "GET help" do
    it "should show the help page" do
      get :help
      assigns['page_title'].should_not be_nil
      response.should be_success
    end
  end
  
  describe "GET contact" do
    it "should show the contact page" do
      get :contact
      assigns['page_title'].should_not be_nil
      response.should be_success
    end
  end
  
  describe "GET terms_of_use" do
    it "should show the terms_of_use page" do
      get :terms_of_use
      assigns['page_title'].should_not be_nil
      response.should be_success
    end
  end
  
  describe "GET privacy_policy" do
    it "should show the privacy_policy page" do
      get :privacy_policy
      assigns['page_title'].should_not be_nil
      response.should be_success
    end
  end
end
