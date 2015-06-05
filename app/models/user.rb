class User < ActiveRecord::Base
  def get(params)
    response_code = "200"
    search_query = {}

    params.each do |k, v|
      puts k.inspect
      search_query[k] = v if k == "id" || k == "name" || k == "password" || k == "settings" || k == "message_ids"
    end

    response = User.where(search_query)
    response = response.first if response.size == 1

    [response, response_code]
  end

  def name_taken?(name)
    User.where(name: name).size > 0 ? true : false
  end

  def update_message_history(message_id)
    self.message_count += 1
    self.message_ids += message_id.to_s + "+"
    self.save
  end

  def get_message_history(user)
    response_code = "200"
    message_history = {}
    message_history[:body] = []
    message_history[:timestamp] = []
    message_history[:chatroom] = []
    message_ids = user.message_ids.split("+")
    message_ids.map! { |id| id = id.to_i }
    messages = Message.where(id: message_ids)
    messages.each do |message|
      message_history[:body] << message.body
      message_history[:timestamp] << message.created_at
      message_history[:chatroom] << Chatroom.find(message.chatroom_id).name
    end
    [message_history, response_code]
  end

  def get_leaderboard(timespan)
    response_code = "200"
    leaderboard
    message_ids = user.message_ids.split("+")
    message_ids.map! { |id| id = id.to_i }
    messages = Message.where(id: message_ids)
    messages.each do |message|
      message_history[:body] << message.body
      message_history[:timestamp] << message.created_at
      message_history[:chatroom] << Chatroom.find(message.chatroom_id).name
    end
    [message_history, response_code]
  end
end

