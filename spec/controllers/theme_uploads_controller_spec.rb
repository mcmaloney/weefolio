require 'spec_helper'

describe ThemeUploadsController do
  describe "GET 'new'" do
    it "should allow me to fill the form out if I'm logged in" do
      User.delete_all
      @user = Factory(:user)
      @user.setup
      login_as(@user)
      
      get :new
      response.should be_success
      assigns['theme_upload'].should_not be_nil
    end
    
    it "should not allow me to fill the form out if I'm not logged in" do
      get :new
      response.should redirect_to(login_path)
    end
  end
  
  describe "POST create" do
    it "should allow me to upload if I am logged in" do
      User.delete_all
      @user = Factory(:user)
      @user.setup
      login_as(@user)
      
      post :create, :theme_upload => {:title => "My Awesome Theme", :source_code => "<h1>AWESOME</h1>", :user_id => @user.id}
      response.should redirect_to(themes_path)
    end
    
    it "should not allow me to upload if I'm not logged in" do
      post :create, :theme_upload => {:title => "My Awesome Theme", :source_code => "<h1>AWESOME</h1>" }
      response.should redirect_to(login_path)
    end
  end
end
