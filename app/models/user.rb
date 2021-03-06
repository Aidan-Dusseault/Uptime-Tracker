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

  attr_accessor :password
  attr_accessible :name, :username, :email, :password, :password_confirmtaion

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :memberships
  has_many :accounts, :through => :memberships

  validates :username, :presence   => true,
                       :uniqueness => { :case_sensitive => false },
                       :length     => { :maximum => 20 }
  validates :email, :presence   => true,
                    :uniqueness => { :case_sensitive => false }
                    :format     => { :with => email_regex }
  validates :password, :presence     => true,
                       :confirmation => true,
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
