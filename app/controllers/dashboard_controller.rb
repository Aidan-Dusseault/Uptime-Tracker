class DashboardController < ApplicationController

  def index
    @title = "Dashboard"
    @recent_events = compile_recent
  end

  private
    
    def compile_recent
      user_domains = Array.new 
      user_events = Array.new
      recent_array = Array.new
      
      current_user.accounts.each do |account|
        user_domains << account.domains
      end
      user_domains = user_domains.flatten
      user_domains.each do |domain|
        user_events << domain.events
      end
      user_events = user_events.flatten
      user_events.sort_by {|hsh| hsh[:created_at]}
      5.times do |n|
        recent_array << user_events[n-1]
      end
      return recent_array
    end
end
