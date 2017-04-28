class PagesController < ApplicationController
	def index
		@listings = Listing.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
	end
end
