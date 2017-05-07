class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing
	has_one :payment

	validate :available?

	def available?
		self.errors.add(:start_date, "You can only make reservations from #{Date.today} onwards.") if self.end_date < Date.today
		byebug
		active_res = Reservation.where('listing_id = ? AND (start_date >= ? OR end_date >= ?)', listing.id,  Date.today, Date.today)
		# active_res = Reservation.where('start_date >= ? OR end_date >= ?', Date.today, Date.today)
		active_res.each do |booking|
			if (self.start_date..self.end_date).overlaps?(booking.start_date..booking.end_date)
				self.errors.add(:start_date, "There's an overlap on your start date or your end date")
				# errors.add(:end_date, "There's an overlap on your end date")
			end
		end
	end

	def get_nights
		nights = self[:end_date] - self[:start_date]
		nights.to_i
	end

	def get_price
		nights = self.get_nights
		total_price = self.listing[:price] * nights
	end
end