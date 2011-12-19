require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :name                  => "Example User",
              :username              => "Username",
              :email                 => "example@email.com",
              :password              => "password",
              :password_confirmation => "password" }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a username" do
    no_name_user = User.new(@attr.merge(:username => ""))
    no_name_user.should_not be_valid
  end

  it "should require an email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject duplicate usernames" do
    User.create(@attr)
    user_with_duplicate_name = User.new(@attr.merge(:email => "another@email.com"))
    user_with_duplicate_name.should_not be_valid
  end

  it "should reject duplicate emails regardless of case" do
    User.create(@attr)
    user_with_duplicate_email = User.new(@attr.merge(:username => "anotheruser"))
    user_with_duplicate_email.should_not be_valid
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => ""))
      should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid"))
      should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
  end
end
