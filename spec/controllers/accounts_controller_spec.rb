require 'spec_helper'

describe AccountsController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    describe "failure" do

      before(:each) do
        @attr = { :name => "" }
        test_sign_in
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
        test_sign_in
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
