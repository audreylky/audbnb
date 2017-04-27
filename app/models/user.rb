class User < ApplicationRecord
  include Clearance::User
  validates :name, :gender, :age, presence: true
  #validation for email & password is already pre-written

  # enumerables (0: undefined, 1: male, 2: female)
  enum gender: [:undefined, :male, :female]
end
