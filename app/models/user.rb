class User < ApplicationRecord
  include Clearance::User
  # validates :name, :gender, :age, presence: true
  #validation for email & password is already pre-written

  # enumerables (0: undefined, 1: male, 2: female)
  enum gender: [:undefined, :male, :female]

  has_many :authentications, :dependent => :destroy

  def self.create_with_auth_and_hash(authentication, auth_hash)
      user = User.create!(name: auth_hash["name"], email: auth_hash["extra"]["raw_info"]["email"])
      user.authentications << (authentication)      
      return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  private
  def password_optional?
    true
  end
end
