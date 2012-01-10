class Event < ActiveRecord::Base

  belongs_to :domain

  default_scope :order => 'events.created_at DESC'
end
