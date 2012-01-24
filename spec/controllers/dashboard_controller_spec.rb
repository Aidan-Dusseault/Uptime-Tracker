require 'spec_helper'

describe DashboardController do
  
  describe "GET 'index'" do

    describe "for non-signed in users" do
      
      it "should redirect to the signin page" do
        get 'index'
        response.should redirect_to(signin_path)
      end
    end

    describe "for signed-in users" do

      before(:each) do
        @user = test_sign_in(Factory(:user, :username => Factory.next(:username), :email => Factory.next(:email)))
        @account = Account.create(:name => "Account")
        @user.accounts << @account
        @domain = Factory(:domain, :account_id => @account.id)
        @event1 = Factory(:event, :domain_id => @domain.id)
        @event2 = Factory(:event, :status_change => 0, :domain_id => @domain.id, :created_at => Time.now + 5)
        @event3 = Factory(:event)
      end
      
      it "should be successful" do
        get 'index'
        response.should be_success
      end
      it "should have the right title" do
        get 'index'
        response.should have_selector("title", :content => "Dashboard")
      end
      it "should include a feed of the user's recent events" do
        get 'index'
        Event.recent_by_user(controller.current_user).should include(@event1)
      end
      it "should not include events from other users" do
        get 'index'
        Event.recent_by_user(controller.current_user).should_not include(@event3)
      end
      it "should place newer events first in the feed" do
        get 'index'
        Event.recent_by_user(controller.current_user).first.should == @event2
      end
    end
  end
end