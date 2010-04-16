require 'spec_helper'

describe PortfoliosController do
  before(:each) do
    User.delete_all
    @user = Factory(:user)
    @user.setup
    login_as(@user)
  end
  
  describe "GET show" do
    it "should show my portfolio" do
      get :show, :id => @user.login
      assigns['user'].login.should == @user.login
      assigns['design'].should_not be_nil
      assigns['portfolio'].should_not be_nil
      assigns['page_title'].should == "Weefolio - #{assigns['user'].login}"
    end
  end
  
  describe "GET edit" do
    it "should allow me to edit my portfolio" do
      get :edit, :id => @user.login
      assigns['user'].login.should == @user.login
      assigns['design'].should_not be_nil
      assigns['portfolio'].should_not be_nil
      assigns['page_title'].should == "Weefolio - Manage My Work"
    end
  end
  
  describe "POST send_message" do
    it "should allow me to send the user a message if I fill out all the fields" do
      post :send_message, :id => @user.login, :from => Faker::Internet.email, :name => Faker::Name.first_name, :message => Faker::Lorem.paragraph
      response.should redirect_to(user_portfolio_path(@user, @user.portfolio))
      flash[:notice].should == "Your <strong>message</strong> has been sent."
    end
    
    it "should not allow me to send a message if I haven't filled out the fields" do
      post :send_message, :id => @user.login, :from => Faker::Internet.email, :name => nil, :message => nil
      response.should redirect_to(user_portfolio_path(@user, @user.portfolio))
      flash[:notice].should == "YOU MUST FILL IN NAME, EMAIL AND MESSAGE."
    end
  end

end
