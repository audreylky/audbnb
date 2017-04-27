class User < ApplicationRecord
  include Clearance::User
  # validates :name, :gender, :age, presence: true
  #validation for email & password is already pre-written

  # enumerables (0: undefined, 1: male, 2: female)
  enum gender: [:undefined, :male, :female]

  has_many :authentications, :dependent => :destroy

  def self.create_with_auth_and_hash(authentication, auth_hash)
    create! do |u|
      # user = User.create!(name: auth_hash["extra"]["raw_info"]["name"], email: auth_hash["extra"]["raw_info"]["email"], gender: auth_hash["extra"]["raw_info"]["gender"])
      # user.authentications << (authentication)     
      # return user
      u.name = auth_hash["extra"]["raw_info"]["name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.gender = auth_hash["extra"]["raw_info"]["gender"]
      u.authentications << (authentication) 
      u.password = "#{SecureRandom.hex(5)}"
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  # private
  # def password_optional?
  #   true
  # end
end
