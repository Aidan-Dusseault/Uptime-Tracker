class Membership < ActiveRecord::Base

  attr_accessible :user_id, :account_id, :owner

  belongs_to :user
  belongs_to :account
end
