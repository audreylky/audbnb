class ListingTagsController < ApplicationController
	def create
		@tag = Tag.new(tag_params)

		if @tag.save
			redirect_to @tag # 'tags#show'
		else
			render 'new'
		end
	end
end
