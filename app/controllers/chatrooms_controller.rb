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

  def leave
    begin
      current_chatroom = Chatroom.find(params[:id])
      response, response_code = current_chatroom.leave(params[:user_id])
      render_response(response, response_code)
      rescue ActiveRecord::RecordNotFound => error
        render_response(error.message, 404)
      rescue StandardError => error
        render_response(error.message, 422)
    end
  end

  def join
    begin
      current_chatroom = Chatroom.find(params[:id])
      response, response_code = current_chatroom.join(params[:user_id])
      render_response(response, response_code)
      rescue ActiveRecord::RecordNotFound => error
        render_response(error.message, 404)
      rescue StandardError => error
        render_response(error.message, 422)
    end
  end

  def users
    begin
      current_chatroom = Chatroom.find(params[:id])
      response, response_code = current_chatroom.get_current_users
      render_response(response, response_code)
      rescue ActiveRecord::RecordNotFound => error
        render_response(error.message, 404)
      rescue StandardError => error
        render_response(error.message, 422)
    end
  end

  def contents
    begin
      current_chatroom = Chatroom.find(params[:id])
      response, response_code = current_chatroom.get_contents(params[:user_id])
      response, response_code = current_chatroom.filter_contents(response, params[:user_id])
      render_response(response, response_code)
      rescue ActiveRecord::RecordNotFound => error
        render_response(error.message, 404)
      rescue StandardError => error
        render_response(error.message, 422)
    end
  end

  def active
    begin
      chatroom = Chatroom.new
      response, response_code = chatroom.get_active
      render_response(response, response_code)
      rescue ActiveRecord::RecordNotFound => error
        render_response(error.message, 404)
      rescue StandardError => error
        render_response(error.message, 422)
    end
  end

  def create
    begin
      create_params = {}
      params.each do |k, v|
        create_params[k] = v if k == "name"
      end
      new_chatroom = Chatroom.create(create_params)
      new_chatroom.join(2)
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
      chatroom.name = params[:name]
      chatroom.save
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

