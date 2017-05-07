class Payment < ApplicationRecord
	belongs_to :reservation
	belongs_to :listing

	belongs_to :landlord, class_name: "Listing", foreign_key: "user_id"
	belongs_to :tenant, class_name: "Reservation", foreign_key: "user_id"
end
