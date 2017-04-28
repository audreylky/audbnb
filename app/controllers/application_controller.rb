class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  # if you want to do the Bootstap colors!
  add_flash_types :success, :warning, :danger, :info
end
