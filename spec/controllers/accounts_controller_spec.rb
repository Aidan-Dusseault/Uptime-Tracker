require 'spec_helper'

describe AccountsController do

  describe "GET 'new'" do
    
    describe "for someone not signed in" do
      
      it "should redirect to the signin page" do
        get :new
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for a signed in user" do
    
      before(:each) do
        test_sign_in(Factory(:user, :username => "Test User", :email => "email@email.com"))
      end
      
      it "should be successful" do
        get :new
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
  
  describe "GET 'edit'" do
    
    describe "for a non-signed in user" do
      
      before(:each) do
        @account = Factory(:account)
      end
      
      it "should redirect to the signin path" do
        get :edit, :id => @account.id
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for a signed-in user" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user, :username => Factory.next(:username), :email => Factory.next(:email)))
        @account = Account.create(:name => "Account")
        @user.accounts << @account
      end
      
      describe "for a non-owner" do
        
        before(:each) do
          @not_owned_account = Factory(:account)
        end
        
        it "should redirect to the root path" do
          get :edit, :id => @not_owned_account.id
          response.should redirect_to(root_path)
        end
      end
      
      describe "for an owner" do
        
        it "should be a success" do
          get :edit, :id => @account
          response.should be_success
        end
        it "should have the right title" do
          get :edit, :id => @account
          response.should have_selector("title", :content => "Edit Account")
        end
      end
    end
  end
  
  describe "POST 'update'" do
    
    describe "for a non-signed in user" do
      
      before(:each) do
        @account = Factory(:account)
      end
      
      it "should redirect to the signin page" do
        put :update, :id => @account.id, :account => {}
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for a signed-in user" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user, :username => Factory.next(:username), :email => Factory.next(:username)))
      end
      
      describe "for a non-owner" do
        
        before(:each) do
          @other_users_account = Factory(:account)
        end
        
        it "should redirect to the root path" do
          put :update, :id => @other_users_account.id, :account => {}
          resonse.should redirect_to(root_path)
        end
      end
      
      describe "for an owner" do
        
        before(:each) do
          @account = Account.create(:name => "Name")
          @user.accounts << @account
        end
        
        describe "failure" do
          
          before(:each) do
            @attr = { :name => "" }
          end
          
          it "should render the 'edit' page" do
            put :update, :id => @account.id, :account => @attr
            response.should render_template('edit')
          end
          it "should have the right title" do
            put :update, :id => @account.id, :account => @attr
            response.should have_selector("title", :content => "Edit Account")
          end
        end
        
        describe "success" do
          
          before(:each) do
            @attr = { :name => "Name" }
          end
          
          it "should change the account's attributes" do
            put :update, :id => @account.id, :account => @attr
            @account.reload
            @account.name.should == @attr[:name]
          end
          it "should redirect to the account's show page" do
            put :update, :id => @account.id, :account => @attr
            response.should redirect_to(account_path(@account.id))
          end
          it "should have a flash message" do
            put :update, :id => @account.id, :account => @attr
            flash[:success].should =~ /updated/
          end
        end
      end
    end
  end
end
