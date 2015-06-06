class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
# This is used to allow the cross origin POST requests made by confroom kiosk app.
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = "*"
    headers['Access-Control-Request-Method'] = %w{GET PUT POST DELETE OPTIONS}.join(",")
  end

  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
end
