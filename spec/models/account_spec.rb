require 'spec_helper'

describe Account do
  

  before(:each) do
    @user = Factory(:user, :name => Factory.next(:username), :email => Factory.next(:email))
    @attr = { :name => "Test Account", :user => @user }
  end

  it "should create a new instance given valid attributes" do
    account = Account.create!(@attr)
  end

  it "should reject accounts without a name" do
    account = Account.create(@attr.merge(:name => ""))
    account.should_not be_valid
  end

  it "should reject accounts with long names" do
    long = "a" * 21
    account = Account.create(@attr.merge(:name => long))
    account.should_not be_valid
  end

  it "should have at least one user" do
    account = @user.accounts.build(@attr)
    account.save
    @user.accounts << account
    account.users.should include(@user)
  end
end
