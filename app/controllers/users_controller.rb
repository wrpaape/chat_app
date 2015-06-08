class UsersController < ApplicationController

  def index
    begin
      if params[:id] || params[:name] || params[:password] || params[:settings] || params[:message_ids]
        user_match = User.new
        response, response_code = user_match.get(params)
        render_response(response, response_code)
      else
        all_users = User.all
        render_response(all_users, 200)
      end
      rescue ActiveRecord::RecordNotFound => error
        render_response(error.message, 404)
      rescue StandardError => error
        render_response(error.message, 422)
    end
  end

  def new
    new_user = User.create
    general_chat = Chatroom.first
    general_chat.join(new_user.id)
    render_response(new_user, 200)
  end

  def create
    begin
      new_user = User.new
      if new_user.name_taken?(params[:name])
        render_response("'#{params[:name]}' has been already taken", 200)
      else
        create_params = {}
        params.each do |k, v|
          create_params[k] = v if k == "name" || k == "password" || k == "message_ids" || k == "settings"
        end
        new_user = User.create(create_params)
        general_chat = Chatroom.first
        general_chat.join(new_user.id)
        render_response(new_user, 200)
      end
      rescue ActiveRecord::RecordNotFound => error
        render_response(error.message, 404)
      rescue StandardError => error
        render_response(error.message, 422)
    end
  end

  def messages
    begin
      current_user = User.find(params[:id])
      response, response_code = current_user.get_message_history
      render_response(response, response_code)
      rescue ActiveRecord::RecordNotFound => error
        render_response(error.message, 404)
      rescue StandardError => error
        render_response(error.message, 422)
    end
  end

  def show
    begin
      user_match = User.new
      response, response_code = user_match.get(params)
      render_response(response, response_code)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error.message, 404)
    rescue StandardError => error
      render_response(error.message, 422)
    end
  end

  def leaderboard
    begin
      user = User.new
      response, response_code = user.get_leaderboard(params[:user_id])
      render_response(response, response_code)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error.message, 404)
    rescue StandardError => error
      render_response(error.message, 422)
    end
  end

  def settings_add
    begin
      current_user = User.find(params[:id])
      response, response_code = current_user.settings_add(params[:settings])
      render_response(response, response_code)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error.message, 404)
    rescue StandardError => error
      render_response(error.message, 422)
    end
  end

  def settings_delete
    begin
      current_user = User.find(params[:id])
      response, response_code = current_user.settings_delete(params[:settings])
      render_response(response, response_code)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error.message, 404)
    rescue StandardError => error
      render_response(error.message, 422)
    end
  end

  def chatrooms
    begin
      current_user = User.find(params[:id])
      response, response_code = current_user.current_chatrooms
      render_response(response, response_code)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error.message, 404)
    rescue StandardError => error
      render_response(error.message, 422)
    end
  end

  def logout
    begin
      current_user = User.find(params[:user_id])
      response, response_code = current_user.logout
      render_response(response, response_code)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error.message, 404)
    rescue StandardError => error
      render_response(error.message, 422)
    end
  end

  def update
    begin
      response_code = "200"
      current_user = User.find(params[:id])
      update_params = {}
      params.each do |k, v|
        update_params[k] = v if k == "name" || k == "password"
      end
      response, response_code = current_user.update(update_params)
      render_response(response, response_code)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error.message, 404)
    rescue StandardError => error
      render_response(error.message, 422)
    end
  end

  def destroy
    begin
      user = User.find(params[:id])
      user.destroy
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
