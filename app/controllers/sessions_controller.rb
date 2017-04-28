class SessionsController < Clearance::SessionsController
  def create
    @user = authenticate(params)

    # sign_in(@user) do |status|
    #   if status.success?
    #     flash[:success] = "Welcome #{current_user.name}!"
    #     redirect_back_or url_after_create
    #   else
    #     respond_to do |format|
    #       format.html {render template: "sessions/new", status: :unauthorized, flash[:danger] = status.failure_message}
    #       format.js {render "alert('Hello Rails');" }
    #     end
    #   end

    sign_in(@user) do |status|
      if status.success?
      	flash[:success] = "Welcome #{current_user.name}!"
        redirect_back_or url_after_create
      else
        # flash.now.notice = status.failure_message
        flash[:danger] = status.failure_message
        render template: "sessions/new", status: :unauthorized
      end
    end
  end

  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    # byebug
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
    if authentication.user
      user = authentication.user 
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = "Signed in!"
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      @next = root_url
      # @next = edit_user_path(user)   
      @notice = "User created - confirm or edit details..."
    end
    sign_in(user)
    redirect_to @next, :notice => @notice
  end
end