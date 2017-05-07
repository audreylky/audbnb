class Payment < ApplicationRecord
	# 1 layer
	belongs_to :reservation, inverse_of: :payment

	# 2 layers
	has_one :listing, through: :reservation # Bi-directional 1-M relationship. Accompanied --> has_many :payments, through: :reservations

	# 3 layers
	has_one :host, through: :listing
	has_one :customer, through: :reservation
	
end