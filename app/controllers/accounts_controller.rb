class AccountsController < ApplicationController

  def new
    if signed_in?
      @title = "New Account"
      @account = Account.new
    else
      redirect_to signin_path
    end
  end

  def create
    if signed_in?
      @account = current_user.accounts.build(params[:account])

      if @account.save
        current_user.accounts << @account
        m = @account.memberships.first
        m.owner = true
        m.save

        redirect_to dashboard_path
      else
        @title = "New Account"
        render :action => 'new'
      end
    else
      redirect_to signin_path
    end
  end
  
  def show
    @account = Account.find(params[:id])
    @title = @account.name
    @recent_events = Event.recent_by_account(@account).limit(5)
  end
end
