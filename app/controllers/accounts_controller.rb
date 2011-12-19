class AccountsController < ApplicationController

  def new
    @title = "New Account"
    @account = Account.new
  end

  def create
    @account = current_user.accounts.build(params[:account])

    if @account.save
      current_user.accounts << @account
      @account.memberships.first.owner = true
      @account.memberships.first.save

      #Change to redirect_to dashboard_path
      redirect_to root_path
    else
      @title = "New Account"
      render :action => 'new'
    end
  end
end
