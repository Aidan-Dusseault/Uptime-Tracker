require 'spec_helper'

describe DomainsController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    describe "failure" do

      before(:each) do
        @attr = { :name => "", :address => "", :account_id => "", :check_interval => 5 }
      end

      it "should not create a domain" do
        lambda do
          post :create, :domain => @attr
        end.should_not change(Domain, :count)
      end

      it "should render the new page" do
        post :create, :domain => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "Domain", :address => "www.google.ca", :account_id => Factory(:account).id, :check_interval => 5 }
      end

      it "should create a domain" do
        lambda do
          post :create, :domain => @attr
        end.should change(Domain, :count).by(1)
      end

      it "should set the last_checked time for the domain" do
      end

      it "should redirect to the dashboard" do
      end
    end
  end
end
