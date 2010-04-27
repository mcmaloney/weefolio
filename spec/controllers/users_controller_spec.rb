require 'spec_helper'

describe UsersController do
  
  # This is the directory view.
  describe "GET index" do
    before(:each) do
      User.delete_all
      @user_1 = Factory(:user)
      @user_1.setup
      @user_2 = Factory(:user)
      @user_2.setup
    end
      
    it "should show only users I searched for" do
      get :index, :search => @user_1.login
      assigns['users'].should include(@user_1)
      assigns['users'].should_not include(@user_2)
    end
    
    it "should show me all the users if I don't enter any search params" do
      get :index, :search => ""
      assigns['users'].should include(@user_1)
      assigns['users'].should include(@user_2)
    end
  end
  
  describe "GET new" do
    it "should let me set up my account" do
      get :new
      assigns['page_title'].should == "Weefolio - Pricing &amp; Sign Up"
    end
  end
  
  describe "GET edit" do
    it "should let me edit my account if I'm logged in" do
      User.delete_all
      @user = Factory(:user)
      @user.setup
      login_as(@user)
      get :edit
      assigns['user'].should_not be_nil
      assigns['page_title'].should == "Weefolio - My Account"
    end
  end
  
  describe "PUT update" do
    before(:each) do
      User.delete_all
      @user = Factory(:user)
      @user.setup
      login_as(@user)
    end
    
    it "should only update my personal settings if I don't change my plan level" do
      put :update, :plan => {:level => "1"}, :user => {:tagline => Faker::Lorem.sentence }
      response.should redirect_to(edit_user_path(assigns['user']))
      flash[:notice].should == "Account settings saved."
    end
    
    it "should update my personal settings and my plan settings if I change both" do
      put :update, :plan => { :level => 2, 
                              :card_number => "4007000000027", 
                              :card_verification => "123", 
                              :card_expiration_month => "4", 
                              :card_expiration_year => "2012", 
                              :card_type => "Visa", 
                              :billing_first_name => Faker::Name.first_name,
                              :billing_last_name => Faker::Name.last_name,
                              :billing_address => Faker::Address.street_address,
                              :billing_city => Faker::Address.city,
                              :billing_state => Faker::Address.us_state,
                              :billing_postal_code => Faker::Address.zip_code }, :user => { :tagline => Faker::Lorem.sentence }
      assigns['user'].plan.level.should == 2
      response.should redirect_to(edit_user_path(assigns['user']))
      flash[:notice].should == "Plan changed to #{assigns['user'].render_account_tier}"
    end
    
    it "should not update my plan and stuff if I put in bogus info for the plan" do
      put :update, :plan =>{ :level => 2, 
                              :card_number => "4007", 
                              :card_verification => "123", 
                              :card_expiration_month => "4", 
                              :card_expiration_year => "2012", 
                              :card_type => "Visa", 
                              :billing_first_name => Faker::Name.first_name,
                              :billing_last_name => Faker::Name.last_name,
                              :billing_address => Faker::Address.street_address,
                              :billing_city => Faker::Address.city,
                              :billing_state => Faker::Address.us_state,
                              :billing_postal_code => Faker::Address.zip_code }, :user => { :tagline => Faker::Lorem.sentence }
      response.should redirect_to(edit_user_path(assigns['user']))
      flash[:notice].should == "Something's gone wrong! Try again, please."
    end
    
    it "should prompt me to delete pieces if I try to downgrade" do
      @user.plan.update_attribute(:level, 2)
      15.times do 
        @user.portfolio.pieces << Factory(:piece)
      end
      put :update, :plan => { :level => 1 }
      flash[:notice].should include("Wait a minute!")
      response.should redirect_to(edit_user_path(assigns['user']))
    end
    
    it "should let me downgrade if everything is cool" do
      @user.plan.update_attribute(:level, 2)
      4.times do
        @user.portfolio.pieces << Factory(:piece)
      end
      put :update, :plan => { :level => 1 }
      "Plan changed to #{assigns['user'].render_account_tier}"
      assigns['user'].plan.level.should == 1
      response.should redirect_to(edit_user_path(assigns['user']))
    end
    
    it "should not let me downgrade if I give it bogus info" do
      @user.plan.update_attribute(:level, 3)
      4.times do
        @user.portfolio.pieces << Factory(:piece)
      end
      put :update, :plan => { :level => 2, 
                              :card_number => "4007", 
                              :card_verification => "123", 
                              :card_expiration_month => "4", 
                              :card_expiration_year => "2012", 
                              :card_type => "Visa", 
                              :billing_first_name => Faker::Name.first_name,
                              :billing_last_name => Faker::Name.last_name,
                              :billing_address => Faker::Address.street_address,
                              :billing_city => Faker::Address.city,
                              :billing_state => Faker::Address.us_state,
                              :billing_postal_code => Faker::Address.zip_code }
      flash[:notice].should == "Something's gone wrong! Try again, please."
    end
  end
  
  describe "POST create" do
    it "should let me create a new user" do
      User.delete_all
      post :create, :user => {:login => Faker::Internet.user_name, :email => Faker::Internet::email, :password => "giraffe", :password_confirmation => "giraffe" }
      response.should redirect_to(root_path)
      flash[:notice].should == "Welcome to Weefolio, #{assigns['user'].login}!"
    end
    
    it "should not let me create a user if I give bogus info" do
      User.delete_all
      post :create, :user => {:login => Faker::Internet.user_name, :email => Faker::Internet::user_name, :password => "giraffe", :password_confirmation => "giraffe" }
      response.should render_template('new')
      flash[:error].should == "We couldn't set up that account, sorry.  Please try again."
    end
  end
  
  describe "POST reset password" do
    before(:each) do
      User.delete_all
      @user = Factory(:user)
      @user.setup
      login_as(@user)
    end
    
    it "should allow me to change my password" do
      post :reset_password, :user => {:login => @user.login, :email => @user.email, :new_password => "giraffe7", :new_password_confirm => "giraffe7" }
      response.should redirect_to(login_path)
      flash[:notice].should == "Password changed. You can now login with your new password."
    end
    
    it "should not allow me to change my password if I give it the wrong email" do
      post :reset_password, :user => {:login => @user.login, :email => Faker::Internet.email, :new_password => "giraffe7", :new_password_confirm => "giraffe7" }
      response.should render_template('reset_password')
      flash[:notice].should == "Bad login/email. Please try again."
    end
    
    it "should not allow me to change my password if I give it the wrong login" do
      post :reset_password, :user => {:login => Faker::Internet.user_name, :email => @user.email, :new_password => "giraffe7", :new_password_confirm => "giraffe7" }
      response.should render_template('reset_password')
      flash[:notice].should == "Bad login/email. Please try again."
    end
    
    it "should not allow me to change my password if it's too short or some shit" do
      post :reset_password, :user => {:login => @user.login, :email => @user.email, :new_password => "g", :new_password_confirm => "g" }
      response.should redirect_to(forgot_password_path)
      flash[:notice].should == "Something went wrong. Please try again."
    end
  end
  
  describe "PUT change design type" do
    before(:each) do
      User.delete_all
      @user = Factory(:user)
      @user.setup
      login_as(@user)
    end
    
    it "should should switch my design type to 2 if it's 1" do
      @user.design_type = 1
      put :switch_design_type, :id => @user.id
      assigns['user'].design_type.should == 2
      response.should redirect_to(edit_user_design_path(assigns['user'], assigns['user'].design))
    end
    
    it "should should switch my design type to 1 if it's 2" do
      User.delete_all
      @user2 = Factory(:user, :design_type => 2)
      @user2.setup
      login_as(@user2)
      put :switch_design_type, :id => @user2.id
      assigns['user'].design_type.should == 1
      response.should redirect_to(edit_user_design_path(assigns['user'], assigns['user'].design))
    end
  end
  
  describe "POST remove account" do
    before(:each) do
      User.delete_all
      @user = Factory(:user)
      @user.setup
      login_as(@user)
    end
    
    it "should allow me to remove my account" do
      post :remove_account
      response.should redirect_to(logout_path)
      User.count.should == 0
    end
  end
   
end
