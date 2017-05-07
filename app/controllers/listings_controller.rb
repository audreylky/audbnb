class ListingsController < ApplicationController
	before_action :is_logged_in?, except: [:show ]
	before_action :find_listing, only: [:show, :edit, :update, :destroy]
	before_action only: [:edit, :update, :destroy] do
		redirect_to root_path, warning: 'You can\'t edit this property unless you are the owner!' if current_user.id != @listing.user_id
	end

	def new
		@listing = Listing.new
	end

	def create
		# byebug
		@listing = Listing.new(listing_params)  # <---- get input via STRONG PARAMS
		@listing.user_id = current_user.id

		if @listing.save
			ltags = params[:listing][:tag_ids]
			ltags.each do |ltag|
				if !ltag.empty?
					ListingTag.create(tag_id: ltag.to_i, listing_id: @listing.id)
				end
			end
			redirect_to @listing  # rails is smart enough to go to 'listings#show'
		else
			render 'new'
		end
	end

	def show
		if @listing.nil?
			redirect_to root_path, warning: 'Sadly, this listing does not exist.'
		end
		@listing = Listing.find_by_id(params[:id])
		@reservation = Reservation.new
	end

	def edit
	end

	def update
		# byebug
		@listing.update(listing_params)

		#### Updating Tags by destroying and recreating ###
		# Destroy all
		eltags = ListingTag.where(listing_id: @listing.id)
		eltags.destroy_all
		# recreate
		new_ltags = params[:listing][:tag_ids]
		new_ltags.each do |ltag|
			if !ltag.empty?
				ListingTag.create(tag_id: ltag.to_i, listing_id: @listing.id)
			end
		end
		redirect_to @listing
	end

	def destroy
		@listing.destroy
		redirect_to root_path
	end

	private
		def find_listing
			@listing = Listing.find_by_id(params[:id])
		end

		def listing_params
			params.require(:listing).permit(:home_type, :stay_type, :guest, :bedroom, :bathroom, :title, :address, :price, :user_id, {tag_ids: []}, {photos: []})
		end

		def is_logged_in?
			redirect_to '/sign_in', danger: 'You must login first!' unless signed_in?
		end
end
