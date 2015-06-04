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
    render_response(new_user, 200)
  end

  def create
    new_user = User.create(name: params[:name], password: params[:password], settings: params[:settings], message_ids: params[:message_ids])
    render_response(new_user, 200)
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

  def update
    begin
      user = User.find(params[:id])
      render_response(user, 200)
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
