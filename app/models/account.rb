class Account < ActiveRecord::Base

  attr_accessible :name

  has_many :memberships
  has_many :users, :through => :memberships
  has_many :domains

  validates :name, :presence => true,
                   :length => { :maximum => 20 }
                   
  scope :owners, lambda { 
    
    joins("INNER JOIN memberships on account_id=accounts.id").
    joins("INNER JOIN users on users.id=user_id").
    where("memberships.owner = ?", true)
  }
end
