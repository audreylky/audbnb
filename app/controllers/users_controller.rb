require 'byebug'

class UsersController < Clearance::UsersController

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


  # need to redefine strong params, you are whitelisting what information is coming to you!
	private

  def user_params
      params.require(:user).permit(:name, :age, :email, :gender, :password)
  end
end