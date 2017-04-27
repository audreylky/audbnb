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
end