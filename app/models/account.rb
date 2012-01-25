class Account < ActiveRecord::Base

  attr_accessible :name

  has_many :memberships
  has_many :users, :through => :memberships
  has_many :domains

  validates :name, :presence => true,
                   :length => { :maximum => 20 }
  
  def owners
    
    User.joins("INNER JOIN memberships on user_id=users.id").
    joins("INNER JOIN accounts on accounts.id=account_id").
    where("memberships.owner = ? AND memberships.account_id = ?", true, self.id)
  end
end
