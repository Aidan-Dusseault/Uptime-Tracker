class Domain < ActiveRecord::Base

  attr_accessible :name, :address, :account_id, :check_interval

  belongs_to :account
  has_many :events

  url_regex = /https?:\/\/.+?\..+/i

  before_validation :http_add

  validates :address, :presence => true,
                      :format   => { :with => url_regex }
  validates :name, :length => { :maximum => 20 }
  validates :account, :presence => true
  validates :check_interval, :presence => true

  scope :expired, lambda {
                            where("last_checked + check_interval <= CURRENT_TIMESTAMP")
                         }

  private
    def http_add
      scheme = self.address[0, 8]
      scheme_regex = /https?:\/\//i
      unless scheme[scheme_regex]
        self.address.insert(0, "http://")
      end
    end
end
