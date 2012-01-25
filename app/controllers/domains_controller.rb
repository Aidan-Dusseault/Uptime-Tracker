class DomainsController < ApplicationController

  def new
    if signed_in?
      @title = "New Domain"
      @domain = Domain.new
    else
      redirect_to signin_path
    end
  end
  
  def show
    if signed_in?
      if current_user.accounts.include?(Domain.find(params[:id]).account)
        @title = domain_name(Domain.find(params[:id]))
        @domain = Domain.find(params[:id])
      else
        redirect_to root_path
      end
    else
      redirect_to signin_path
    end
  end

  def create
    if signed_in?
      @domain = Domain.new(params[:domain])
      if @domain.save
        redirect_to "/dashboard"
        else
        @title = "New Domain"
        render 'new'
      end
    else
      redirect_to signin_path
    end
  end
  
  def edit
    if signed_in?
      if Domain.find(params[:id]).owners.include?(current_user)
        @domain = Domain.find(params[:id])
        @title = "Edit Domain"
      else
        redirect_to root_path
      end
    else
      redirect_to signin_path
    end
  end
  
  def update
    @domin = Domain.find(params[:id])
    if @domain.update_attributes(params[:domain])
      flash[:success] = "Domain updated."
      redirect_to @domain
    else
      @title = "Edit Domain"
      render 'edit'
    end
  end
end
