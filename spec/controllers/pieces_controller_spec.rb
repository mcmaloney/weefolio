require 'spec_helper'

describe PiecesController do
  describe "logged in actions" do
    before(:each) do
      User.delete_all
      @user = Factory(:user)
      @user.setup
      login_as(@user)
    end

    describe "GET new" do
      it "should let me setup a new piece" do
        get :new, :piece => {}
        assigns['portfolio'].should_not be_nil
        assigns['user'].should_not be_nil
        assigns['service_types'].should_not be_nil
        assigns['page_title'].should_not be_nil
      end
    end

    describe "POST create" do
      it "should allow me to create a piece with a price" do
        post :create, :piece => { :title => Faker::Lorem.words(2).to_s, :for_sale => true, :price => 25.55 }
        response.should redirect_to(edit_user_portfolio_path(@user, @user.portfolio))
        flash[:notice].should include("<strong>'#{assigns['piece'].title}'</strong> has been added to your Weefolio (for sale at #{assigns['piece'].display_price})")
      end

      it "should allow me to create a piece without a price" do
        post :create, :piece => { :title => Faker::Lorem.words(2).to_s }
        response.should redirect_to(edit_user_portfolio_path(@user, @user.portfolio))
        flash[:notice].should include("<strong>'#{assigns['piece'].title}'</strong> has been added to your Weefolio")
      end

      it "should not let me create a piece if I give bogus info" do
        post :create, :piece => { }
        response.should redirect_to(edit_user_portfolio_path(@user, @user.portfolio))
        flash[:notice].should include("Couldn't upload that piece. Please ty again!")
      end 
    end

    describe "GET edit" do
      it "should allow me to edit a piece" do
        @piece = Factory(:piece, :portfolio_id => @user.portfolio.id)
        @user.portfolio.pieces << @piece
        get :edit, :id => @piece.id
        assigns['service_types'].should_not be_nil
        assigns['page_title'].should_not be_nil
      end
    end

    describe "PUT update" do
      it "should let me update my piece" do
        @piece = Factory(:piece, :portfolio_id => @user.portfolio.id)
        put :update, :id => @piece.id, :piece => { :title => Faker::Lorem.words(2) }
        response.should redirect_to(edit_user_portfolio_path(@user, @user.portfolio))
      end
    end
    
    # Rendering inline. WRITE A TEST!
    # describe "GET show" do
    #       it "should show me a piece I have uploaded" do
    #         @piece = Factory(:piece, :portfolio_id => @user.portfolio.id)
    #         get :show, :id => @piece.id
    #         assigns['page_title'].should include("#{@user.login} - #{assigns['piece'].title}")
    #         assigns['design'].should_not be_nil
    #       end
    #     end 

    describe "DELETE destroy" do
      it "should let me destroy a piece" do
        @user.pieces.delete_all
        @piece = Factory(:piece, :portfolio_id => @user.portfolio.id)
        delete :destroy, :portfolio_id => @user.login, :id => @piece.id
        @user.pieces.count.should == 0
        response.should redirect_to(edit_user_portfolio_path(@user, @user.portfolio))
        flash[:notice].should include("'#{assigns['piece'].title}' has been <strong>deleted</strong>.")
      end
    end

    describe "POST sort" do
      it "should sort the pieces in my portfolio" do
        pieces = []
        @user.pieces.delete_all
        3.times do
          @piece = Factory(:piece, :portfolio_id => @user.portfolio.id)
          pieces << @piece
        end
        post :sort, :portfolio_id => @user.login, :pieces => pieces
        response.should be_success
      end
    end
  end
  
      
       
end
