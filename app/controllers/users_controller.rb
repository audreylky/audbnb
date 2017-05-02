class UsersController < Clearance::UsersController
	before_action :is_logged_in?, only: [:edit]
	before_action :find_user, only: [:show, :edit, :update, :destroy]
	before_action only: [:edit, :update, :destroy] do
		redirect_to root_path, warning: 'You can\'t edit this unless you are the owner!' if current_user.id != @user.id
	end

### If you want to use BYENUG, you've gotta put the original stuff in here ###
	
	def create
	  @user = user_from_params
	  @user.role = "customer"

	  if @user.save
	    sign_in @user
	    flash[:success] = "Congratulations #{current_user.name}!"
	    redirect_back_or url_after_create
	  else
	  	flash[:danger] = "Please register properly"
	  	flash[:danger] = @user.errors.full_messages.join("<br />").html_safe
	    render template: "users/new"
	  end
	end

	def show
		if @user.nil?
			redirect_to root_path, warning: 'Sadly, this person does not exist.'
		end
	end

	def edit
	end

	def update
		@user.update(user_params)
		p @user.errors.full_messages
		redirect_to @user
	end

	def destroy
		@user.destroy
		redirect_to root_path
	end



  # need to redefine strong params, you are whitelisting what information is coming to you!
	private
	def find_user
			@user = User.find_by_id(current_user.id)
		end

  def user_params
      params.require(:user).permit(:name, :age, :email, :gender, :password, :avatar)
  end

  def is_logged_in?
		redirect_to '/sign_in', danger: 'You must login first!' unless signed_in?
	end
end