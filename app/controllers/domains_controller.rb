class DomainsController < ApplicationController

  def new
    @title = "New Domain"
    @domain = Domain.new
  end

  def create
    @domain = Domain.new(params[:domain])
    if @domain.save
      #Change to redirect_to dashboard_path
      redirect_to root_path
    else
      @title = "New Domain"
      render 'new'
    end
  end
end
