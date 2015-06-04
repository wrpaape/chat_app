class ChatroomsController < ApplicationController

  def index
    begin
      if params[:id] || params[:user_id] || params[:message_id]
        chatroom_match = Chatroom.new
        response, response_code = chatroom_match.get(params)
        render_response(response, response_code)
      else
        all_chatrooms = Chatroom.all
        render_response(all_chatrooms, 200)
      end
      rescue ActiveRecord::RecordNotFound => error
        render_response(error.message, 404)
      rescue StandardError => error
        render_response(error.message, 422)
    end
  end

  def new
    new_chatroom = Chatroom.create
    render_response(new_chatroom, 200)
  end

  def create
    begin
      create_params = {}
      params.each do |k, v|
        create_params[k] = v if k == "user_id" || k == "message_id"
      end
      new_chatroom = Chatroom.create(create_params)
      render_response(new_chatroom, 200)
      rescue ActiveRecord::RecordNotFound => error
        render_response(error.message, 404)
      rescue StandardError => error
        render_response(error.message, 422)
    end
  end

  def show
    begin
      chatroom_match = Chatroom.new
      response, response_code = chatroom_match.get(params)
      render_response(response, response_code)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error.message, 404)
    rescue StandardError => error
      render_response(error.message, 422)
    end
  end

  def update
    begin
      chatroom = Chatroom.find(params[:id])
      render_response(chatroom, 200)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error.message, 404)
    rescue StandardError => error
      render_response(error.message, 422)
    end
  end

  def destroy
    begin
      chatroom = Chatroom.find(params[:id])
      chatroom.destroy
      render_response("deleted", 200)
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

