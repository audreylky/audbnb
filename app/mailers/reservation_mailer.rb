class ReservationMailer < ApplicationMailer
	default from: 'audcode@gmail.com'

	def booking_email(customer, host, reservation_id)
  	@customer = customer
  	@host = host
  	# @url  = 'http://localhost:3000/login'
    mail(to: @host.email, subject: 'You have a Booking!')
  end
end