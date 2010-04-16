require 'spec_helper'

include AuthenticatedTestHelper

describe Admin::UsersController do

  describe "GET index" do
    it "should not allow me access if I'm not an admin" do
      User.delete_all
      @user = Factory(:user)
      @user.setup
      login_as(@user)
      get :index
      response.should redirect_to(root_path)
    end
    
    it "should allow me access if I am an admin" do
      User.delete_all
      @user = Factory(:user, :admin_user => true)
      @user.setup
      login_as(@user)
      get :index
      assigns['users'].should_not be_nil
      response.should be_success
    end
  end

end
