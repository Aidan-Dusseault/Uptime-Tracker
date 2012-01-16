class DashboardController < ApplicationController

  def index
    @title = "Dashboard"
    @recent_events = compile_recent
  end

  private
    
    def compile_recent
      @current_user.accounts.each do |account|
        user_domains << account.domains
      end
      user_domains = user_domains.flatten
      user_domains.each do |domain|
        user_events << domain.events
      end
      user_events = user_events.flatten
      user_events.sort_by {|hsh| hsh[:created_at]}
    end
end
