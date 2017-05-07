class BraintreeController < ApplicationController
  def new
  	@client_token = Braintree::ClientToken.generate

  	@payment = Payment.new
  end

	def create
	  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
	  @reservation = Reservation.find_by_id(params[:reservation_id])

	  result = Braintree::Transaction.sale(
	   :amount => @reservation.get_price, #this is currently hardcoded
	   :payment_method_nonce => nonce_from_the_client,
	   :options => {
	      :submit_for_settlement => true
	    }
	   )

	  @payment = Payment.new(reservation_id: params[:reservation_id].to_i, payment_amount: @reservation.get_price)

	  if result.success?
	  	@payment.save
	  	byebug
	  	ReservationMailer.booking_email(@payment.customer, @payment.host, params[:reservation_id].to_i).deliver_now
	    redirect_to :root, :flash => { :success => "Transaction successful!" } 
	  else
	    redirect_to :root, :flash => { :error => "Transaction failed. Please try again." } 
	  end 
	end
end