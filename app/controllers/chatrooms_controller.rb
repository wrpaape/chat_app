class ChatroomsController < ApplicationController

  def index
    begin
      all_chatrooms = Chatroom.all
      render_response(all_chatrooms, 200)

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

