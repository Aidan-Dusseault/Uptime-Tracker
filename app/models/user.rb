# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'digest'
class User < ActiveRecord::Base

  attr_accessible :name, :email, :password, :password_confirmation

  has_many :accounts, :through => :memberships,
                      :source  => "member_id"

  validates :name, :presence   => true,
                   :uniqueness => true { :case_sensitive => false }
                   :length     => { :maximum => 20 }
  validates :password, :presence     => true, 
                       :confirmation => true
                       :length       => { :within => 6..40 }
  
  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def authenticate(name, submitted_password)
    user = User.find_by_name(name)
    return nil if user.nil?
    return user if user.has_password(submitted_password)
  end

  private
    
    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end