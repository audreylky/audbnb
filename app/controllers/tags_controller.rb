class TagsController < ApplicationController
	before_action :is_logged_in?, except: [:show ]
	before_action do
		redirect_to root_path, warning: "Sorry, you are not authorized for that action!" if !current_user.superadmin? # possible because you used the enum method
	end
	before_action :find_tag, only: [:show, :edit, :update, :destroy]

	def new

			@tag = Tag.new
	end

	def create
		@tag = Tag.new(tag_params)

		if @tag.save
			redirect_to @tag # 'tags#show'
		else
			render 'new'
		end
	end

	def show
		if @tag.nil?
			redirect_to new_tag_path, warning: 'Sadly, this tag does not exist.'
		end
	end

	def edit
	end

	def update
		@tag.update(tag_params)
		redirect_to @tag
	end

	def destroy
		@tag.destroy
		redirect_to root_path
	end

	private
	def 

	def find_tag
		@tag = Tag.find_by_id(params[:id])
	end

	def tag_params
		params.require(:tag).permit(:name)
	end

	def is_logged_in?
		redirect_to '/sign_in', danger: 'You must login first!' unless signed_in?
	end

end
