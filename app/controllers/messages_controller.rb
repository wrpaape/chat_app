class MessagesController < ApplicationController

  def index
    begin
      if params[:id] || params[:user_id] || params[:body]
        message_match = User.new
        response, response_code = message_match.get(params)
        render_response(response, response_code)
      else
        all_messages = Message.all
        render_response(all_messages, 200)
      end
      rescue ActiveRecord::RecordNotFound => error
        render_response(error.message, 404)
      rescue StandardError => error
        render_response(error.message, 422)
    end
  end

  def new
    new_message = Message.create
    render_response(new_message, 200)
  end

  def create
    begin
      create_params = {}
      params.each do |k, v|
        create_params[k] = v if k == "user_id" || k == "body"
      end
      new_message = Message.create(create_params)

      current_user = User.find(params[:user_id])
      current_user.update_message_history(new_message.id)

      Chatroom.create(user_id: params[:user_id], message_id: new_message.id)

      render_response(new_message, 200)
      rescue ActiveRecord::RecordNotFound => error
        render_response(error.message, 404)
      rescue StandardError => error
        render_response(error.message, 422)
    end
  end

  def show
    begin
      message_match = Message.new
      response, response_code = message_match.get(params)
      render_response(response, response_code)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error.message, 404)
    rescue StandardError => error
      render_response(error.message, 422)
    end
  end

  def update
    begin
      message = Message.find(params[:id])
      render_response(message, 200)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error.message, 404)
    rescue StandardError => error
      render_response(error.message, 422)
    end
  end

  def destroy
    begin
      message = Message.find(params[:id])
      message.destroy
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
