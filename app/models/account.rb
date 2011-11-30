class Account < ActiveRecord::Base

  has_many :users, :through => :memberships,
                   :source => "account_id"
  has_many :domains

  validates :name, :presence => true,
                   :length => { :maximum => 20 }
end
