require 'spec_helper'

describe DesignsController do
  
  describe "logged in actions" do
    before(:each) do
      User.delete_all
      @user = Factory(:user)
      @user.setup
      login_as(@user)
    end

    describe "GET edit" do
      it "should set the page title" do
        get :edit
        assigns['user'].should_not be_nil
        assigns['design'].should_not be_nil
        assigns['page_title'].should == "Weefolio - Layout Editor"
      end
    end

    describe "PUT update" do
      it "should let me update my design" do
        put :update, :background_color => "#ffffff"
        response.should redirect_to(edit_user_design_path(@user, assigns['design']))
      end
    end 
  end
  
  describe "logged out actions" do
    describe "GET edit" do
      it "should redirect me to the login page" do
        get :edit
        response.should redirect_to(login_path)
      end
    end
    
    describe "PUT update" do
      it "should redirect me to the login page" do
        put :update, :background_color => "#ffffff"
        response.should redirect_to(login_path)
      end
    end
  end
  
end
