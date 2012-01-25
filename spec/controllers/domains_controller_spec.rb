require 'spec_helper'

describe DomainsController do

  describe "GET 'new'" do
    
    describe "for those not signed in" do
    
      it "should redirect to the signin page" do
        get :new
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for a signed in user" do
      
      before(:each) do
        test_sign_in(Factory(:user, :username => Factory.next(:username), :email => Factory.next(:email)))
      end 
      
      it "should be successful" do
        get :new
        response.should be_success
      end
    end
  end
  
  describe "GET 'show" do
    
    describe "for a non-signed-in user" do
      
      before(:each) do
        @domain = Factory(:domain)
      end
      
      it "should redirect to the signin page" do
        get :show, :id => @domain.id
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for a signed-in-user" do
      
      describe "for a non-member of the associated account" do
        
        before(:each) do
          test_sign_in(Factory(:user, :username => Factory.next(:username), :email => Factory.next(:email)))
          account = Account.create(:name => "Account")
          @domain = Domain.create(:name => "Domain", :address => "www.google.ca", :status => 1, :check_interval => 0, :account_id => account.id)
        end
        
        it "should redirect to the root path" do
          get :show, :id => @domain.id
          response.should redirect_to(root_path)
        end
      end
      
      describe "for a member of the associated account" do
        
        before(:each) do
          test_sign_in(Factory(:user, :username => Factory.next(:username), :email => Factory.next(:email)))
          account = Account.create(:name => "Account")
          controller.current_user.accounts << account
          @domain = Domain.create(:name => "Domain", :address => "www.google.ca", :status => 1, :check_interval => 0, :account_id => account.id)
          account.domains << @domain
        end
        
        it "should be successful" do
          get :show, :id => @domain.id
          response.should be_success
        end
        it "should have the right title" do
          get :show, :id => @domain.id
          response.should have_selector("title", :content => domain_name(@domain))
        end
      end
    end
  end

  describe "POST 'create'" do
    
    describe "failure" do

      before(:each) do
        test_sign_in(Factory(:user, :username => Factory.next(:username), :email => Factory.next(:email)))
        @attr = { :name => "", :address => "", :account_id => "", :check_interval => 0 }
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
        test_sign_in(Factory(:user, :name => Factory.next(:username), :email => Factory.next(:email)))
        @attr = { :name => "Domain", :address => "www.google.ca", :account_id => Account.create(:name => "Account").id, :check_interval => 0 }
      end

      it "should create a domain" do
        lambda do
          post :create, :domain => @attr
        end.should change(Domain, :count).by(1)
      end

      it "should redirect to the dashboard" do
        post :create, :domain => @attr
        response.should redirect_to(dashboard_path)
      end
    end
  end
  
  describe "GET 'edit'" do
    
    describe "for a non-signed in user" do
      
      before(:each) do
        @domain = Factory(:domain)
      end
      
      it "should redirect to the signin path" do
        get :edit, :id => @domain.id
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for a signed-in user" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user, :username => Factory.next(:username), :email => Factory.next(:email)))
      end
      
      describe "for a non-owner" do
        
        before(:each) do
          @domain = Factory(:domain)
        end
        
        it "should redirect to the root path" do
          get :edit, :id => @domain.id
          response.should redirect_to(root_path)
        end
      end
      
      describe "for an owner" do
        
        before(:each) do
          @account = Account.create(:name => "Account")
          @user.accounts << @account
          @domain = Factory(:domain, :account_id => @account)
        end
        
        it "should be a success" do
          get :edit, :id => @domain.id
          response.should be_success
        end
        it "should have the right title" do
          get :edit, :id => @domain.id
          response.should have_selector("title", :content => "Edit Domain")
        end
      end
    end
  end
  
  describe "POST 'update'" do
    
    describe "for a non-signed in user" do
      
      before(:each) do
        @domain = Factory(:domain)
      end
      
      it "should redirect to the signin page" do
        put :update, :id => @domain.id, :domain => {}
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for a signed-in user" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user, :username => Factory.next(:username), :email => Factory.next(:username)))
        @account = Account.create(:name => "Name")
        @user.accounts << @account
      end
      
      describe "for a non-owner" do
        
        before(:each) do
          @other_users_domain = Factory(:domain)
        end
        
        it "should redirect to the root path" do
          put :update, :id => @other_users_domain.id, :domain => {}
          resonse.should redirect_to(root_path)
        end
      end
      
      describe "for an owner" do
        
        before(:each) do
          @domain = Factory(:domain, :account_id => @account.id)
        end
        
        describe "failure" do
          
          before(:each) do
            @attr = { :name => "", :address => "", :check_interval => "", :account_id => "" }
          end
          
          it "should render the 'edit' page" do
            put :update, :id => @domain.id, :domain => @attr
            response.should render_template('edit')
          end
          it "should have the right title" do
            put :update, :id => @domain.id, :domain => @attr
            response.should have_selector("title", :content => "Edit Account")
          end
        end
        
        describe "success" do
          
          before(:each) do
            @attr = { :name => "Name", :address => "www.google.ca", :check_interval => 5, :account_id => @account.id }
          end
          
          it "should change the domain's attributes" do
            put :update, :id => @domain.id, :domain => @attr
            @domain.reload
            @domain.name.should == @attr[:name]
            @domain.address.should == @attr[:address]
            @domain.check_interval.should == @attr[:check_interval]
            @domain.account_id.should == @attr[:account_id]
          end
          it "should redirect to the domain's show page" do
            put :update, :id => @domain.id, :domain => @attr
            response.should redirect_to(domain_path(@domain.id))
          end
          it "should have a flash message" do
            put :update, :id => @domain.id, :domain => @attr
            flash[:success].should =~ /updated/
          end
        end
      end
    end
  end
end
