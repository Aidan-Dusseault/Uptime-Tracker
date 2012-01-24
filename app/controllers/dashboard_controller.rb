class DashboardController < ApplicationController
  
  def index
    if signed_in?
      @title = "Dashboard"
      @recent_events = compile_recent
    else
      redirect_to signin_path
    end
  end

  private
    
    def compile_recent
      recent_array = Event.recent_by_user(current_user).limit(5)
    end
end
