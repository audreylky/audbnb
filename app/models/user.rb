class User < ApplicationRecord
  include Clearance::User
  # validates :name, :gender, :age, presence: true
  #validation for email & password is already pre-written

  # enumerables (0: undefined, 1: male, 2: female)
  enum gender: [:undefined, :male, :female]
  enum role: [:customer, :moderator, :superadmin]

  has_many :authentications, :dependent => :destroy
  has_many :listings, inverse_of: 'host', :dependent => :destroy
  has_many :reservations, inverse_of: 'customer', :dependent => :destroy

  mount_uploader :avatar, AvatarUploader

  def self.create_with_auth_and_hash(authentication, auth_hash)
    create! do |u|
      # user = User.create!(name: auth_hash["extra"]["raw_info"]["name"], email: auth_hash["extra"]["raw_info"]["email"], gender: auth_hash["extra"]["raw_info"]["gender"])
      # user.authentications << (authentication)     
      # return user
      u.name = auth_hash["extra"]["raw_info"]["name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.gender = auth_hash["extra"]["raw_info"]["gender"]
      u.role = "customer"

      # x = auth_hash["extra"]["raw_info"]["birthday"]
      # bday= Date.strptime(x, "%m/%d/%Y")
      # u.birthday = Date.today.year - bday.year

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


##### If you want drop down
# User table
# ----------
# STAY = ["Shared", "Private", "Entire"]

# View
# ----
#  <div>
#    <%= form.select :stay_type, User::STAY, prompt: "- Select type of stay" %>
#  </div>