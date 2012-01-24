class Event < ActiveRecord::Base

  belongs_to :domain
  
  scope :recent_by_user, lambda { |user|
    
    joins("INNER JOIN domains on domains.id=events.domain_id").
    joins("INNER JOIN accounts on accounts.id=domains.account_id").
    joins("INNER JOIN memberships on memberships.account_id=accounts.id").
    joins("INNER JOIN users on users.id=memberships.user_id").
    where("users.id = ?", user.id).
    order("created_at DESC")
  }
  
  scope :recent_by_account, lambda { |account|
    
    joins("INNER JOIN domains on domains.id=events.domain_id").
    joins("INNER JOIN accounts on accounts.id=domains.account_id").
    where("accounts.id = ?", account.id).
    order("created_at DESC")
  }
  
end
