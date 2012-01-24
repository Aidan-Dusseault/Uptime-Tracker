require 'spec_helper'

describe AccountsController do

  describe "GET 'new'" do
    
    describe "for someone not signed in" do
      
      it "should redirect to the signin page" do
        get 'new'
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for a signed in user" do
    
      before(:each) do
        test_sign_in(Factory(:user, :username => "Test User", :email => "email@email.com"))
      end
      
      it "should be successful" do
        get 'new'
        response.should be_success
      end
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      test_sign_in(Factory(:user, :username => "Other Test User", :email => "otheremail@email.com"))
    end
      
    describe "failure" do
    
      before(:each) do
        @attr = { :name => "" }
      end
      
      it "should not create an account" do
        lambda do
          post :create, :account => @attr
        end.should_not change(Account, :count)
      end
    
      it "should render the 'new' page" do
        post :create, :account => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "Account" }
      end

      it "should create an account" do
        lambda do
          post :create, :account => @attr
        end.should change(Account, :count).by(1)
      end

      it "should redirect to the dashboard" do
      end
    end
  end
end
