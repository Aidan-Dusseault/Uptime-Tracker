class UsersController < ApplicationController

  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to dashboard_path
    else
      @title = "Sign up"
      render 'new'
    end
  end
end