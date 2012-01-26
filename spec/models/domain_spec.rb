require 'spec_helper'

describe Domain do

  before(:each) do
    @account = Account.create(:name => "Account")
    @attr = { :name => "Test Domain", :address => "www.google.com", :account_id => @account.id, :check_interval => 5 }
  end

  it "should create a new instance given proper attributes" do
    domain = Domain.create!(@attr)
    domain.should be_valid
  end

  it "should have an address" do
    domain = Domain.create(@attr.merge(:address => ""))
    domain.should_not be_valid
  end

  it "should have a valid address" do
    domain = Domain.create(@attr.merge(:address => "invalid"))
    domain.should_not be_valid
  end

  it "should reject domains with long names" do
    long = "a" * 101
    domain = Domain.create(@attr.merge(:name => long))
    domain.should_not be_valid
  end

  it "should have an account_id" do
    domain = Domain.create(@attr)
    domain.account_id.should be_true
  end

  it  "should have a valid account_id" do
    domain = Domain.create(@attr)
    Account.find(domain.account_id).should be_true
  end

  it "should have a check_interval" do
    domain = Domain.create(@attr.merge(:check_interval => ""))
    domain.should_not be_valid
  end
end
