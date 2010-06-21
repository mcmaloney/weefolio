require 'spec_helper'

describe Admin::ThemesController do
  before(:each) do
    @user = Factory(:user, :admin_user => true)
    @user.setup
    login_as(@user)
    5.times do
      Factory(:theme)
    end
  end

  describe "GET 'index'" do
    it "should show all the themes" do
      get :index
      assigns['themes'].should_not be_nil
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      assigns['theme'].should_not be_nil
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get :edit, :id => Theme.first.id
      assigns['theme'].id.should == Theme.first.id
    end
  end
end
