class Account < ActiveRecord::Base

  attr_accessible :name

  has_many :memberships
  has_many :users, :through => :memberships
  has_many :domains

  validates :name, :presence => true,
                   :length => { :maximum => 20 }
  #validates :users, :presence => true
end
