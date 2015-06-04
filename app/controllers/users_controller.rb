class UsersController < ApplicationController

  def index
    begin
      all_users = User.all
      render_response(all_users, 200)

      rescue ActiveRecord::RecordNotFound => error
        render_response(error.message, 404)
      rescue StandardError => error
        render_response(error.message, 422)
    end
  end

  private

  def render_response(response, response_code)
    render json: response, status: response_code
  end
end
