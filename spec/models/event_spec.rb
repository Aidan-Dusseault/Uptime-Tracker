require 'spec_helper'

describe Event do
  
  before(:each) do
    @domain = Factory(:domain)
    @attr = { :status_change => 0, :domain => @domain }
  end

  describe "feed" do

    it "should have a feed" do
      @event.should respond_to(:feed)
    end
    it "should include the user's events" do
    end
    it "should not include other user's events" do
    end
  end
end
