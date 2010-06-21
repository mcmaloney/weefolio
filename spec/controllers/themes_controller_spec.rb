require 'spec_helper'

describe ThemesController do
  before(:each) do
    @theme = Factory(:theme)
  end
  
  describe "GET index" do
    it "should show all the themes" do
      get :index
      assigns['themes'].should_not be_nil
    end
  end
  
  describe "PUT install" do
    it "should install the theme I have chosen if I am logged in" do
      User.delete_all
      @user = Factory(:user)
      @user.setup
      login_as(@user)
      put :install, :id => @theme.id
      flash[:notice].should include("Installed the #{@theme.name} theme.")
      response.should redirect_to(themes_path)
    end
  end
end
