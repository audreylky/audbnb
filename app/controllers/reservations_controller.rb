class ReservationsController < ApplicationController
	before_action :is_logged_in?, only: [:show]
	before_action :find_reservation, only: [:show, :edit, :update, :destroy]
	before_action only: [:edit, :update, :destroy] do
		redirect_to root_path, warning: 'You can\'t edit this property unless you are the owner!' if current_user.id != @reservation.user_id
	end

############
	def new
		# @listing = Listing.find_by_id(params[:listing_id])
		# @reservation = Reservation.new
	end

	def create
		@reservation = Reservation.new(reformat_params(params))
		@reservation.user_id = current_user.id
		@reservation.listing_id = params[:listing_id]
		if @reservation.save
			flash[:success] = "You have made a reservation!"
			# redirect_to "/listings/#{params[:listing_id]}/reservations/#{@reservation.id}"
			redirect_to listing_reservation_path(@reservation, listing_id: params[:listing_id])
			# redirect_back fallback_location: root_url
		else
			flash[:danger] = "Reservation is unsuccessful. #{@reservation.errors.full_messages.join("<br />").html_safe}"
		    # render template: "reservations/new"
		    params
	    	redirect_to listing_path(id: params[:listing_id])
	  end
	end

	def show
		if @reservation.nil?
			redirect_to listing_path, warning: 'This reservation does not exist.'
		end
	end

	# def index
	# 	@reservations = @listing.reservations
	# end

	def edit
	end

	def update
		if @reservation.update(reformat_params)
			flash[:success] = "Updated!"
			redirect_to @reservation
		else
			flash[:danger] = "Oh no! Something went wrong!"
		end
	end

	def delete
		@reservation.destroy
		redirect_to root_path
	end

	private
	def find_reservation
		# byebug
		@reservation = Reservation.find_by_id(params[:id])
	end

	def is_logged_in?
		redirect_to '/sign_in', danger: 'You must login first!' unless signed_in?
	end

	def reservation_params
		params.require(:reservation).permit(:comments, :daterange)
	end

	def reformat_params(params)
		byebug
		dates = params[:daterange].split(" - ")
		
		start_date = Date.strptime( dates[0], '%m/%d/%Y')
		end_date = Date.strptime( dates[1], '%m/%d/%Y')

		{comments: params[:reservation][:comments], start_date: start_date, end_date: end_date}
	end

end
