class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
# This is used to allow the cross origin POST requests made by confroom kiosk app.

  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
end
