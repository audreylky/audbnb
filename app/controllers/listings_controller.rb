class ListingsController < ApplicationController
	before_action :is_logged_in?, except: [:show ]
	before_action :find_listing, only: [:show, :edit, :update, :destroy]

	def new
		@listing = Listing.new
	end

	def create
		byebug
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
	end

	def edit
	end

	def update
		@listing.update(listing_params)

		#if 1st == 2nd, remain
		#if tag relationship doesn't exist, create new
		#if tag existed, then doesn't exist, destroy
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
			params.require(:listing).permit(:home_type, :stay_type, :guest, :bedroom, :bathroom, :title, :address, :price, :user_id, :tag_ids)
		end

		def is_logged_in?
			redirect_to '/sign_in', danger: 'You must login first!' unless signed_in?
		end
end
