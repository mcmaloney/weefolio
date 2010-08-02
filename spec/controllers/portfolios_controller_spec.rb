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
     get :show, :login => @user.login
     assigns['user'].login.should == @user.login
     assigns['design'].user_id.should == @user.id
     assigns['portfolio'].user_id.should == @user.id
     response.should_not render_template('template')
   end
   
   # it "should do a 404 when it can't find the login so we don't get 500 errors in HopToad..." do
   #   get :show, :login => "sdfjgnmHH"
   #   response.code.should == "404"
   # end
   
   it "should render an rss view as well" do
     get :show, :login => @user.login, :format => "rss"
     assigns['user'].login.should == @user.login
     assigns['design'].user_id.should == @user.id
     assigns['portfolio'].user_id.should == @user.id
     response.should be_success
   end
 end
  
  describe "GET edit" do
    it "should allow me to edit my portfolio" do
      get :edit, :id => @user.id
      assigns['user'].login.should == @user.login
      assigns['design'].should_not be_nil
      assigns['portfolio'].should_not be_nil
      assigns['page_title'].should == "Weefolio - Manage My Work"
    end
  end
  
  describe "POST send_message" do
    it "should allow me to send the user a message if I fill out all the fields" do
      post :send_message, :id => @user.id, :from => Faker::Internet.email, :name => Faker::Name.first_name, :message => Faker::Lorem.paragraph
      response.should redirect_to(user_portfolio_path(@user.login))
      flash[:notice].should == "Your <strong>message</strong> has been sent."
    end
    
    it "should not allow me to send a message if I haven't filled out the fields" do
      post :send_message, :id => @user.id, :from => Faker::Internet.email, :name => nil, :message => nil
      response.should redirect_to(user_portfolio_path(@user.login))
      flash[:notice].should == "YOU MUST FILL IN NAME, EMAIL AND MESSAGE."
    end
  end

end
