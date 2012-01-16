require 'spec_helper'

describe DashboardController do
  
  describe "GET 'index'" do

    describe "for non-signed in users" do
      it "should redirect to the signin page" do
        get :index
        response.should redirect_to(signin_path)
      end
    end

    describe "for signed-in users" do

      before(:each) do
        @user = test_sign_in
        @user.accounts << Factory(:account)
      end

      it "should be successful" do
        get :index
        response.should be_success
      end
      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "Dashboard")
      end
      it "should include a feed of recent events" do
        
      end
    end
  end
end
