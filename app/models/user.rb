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

  def update(params)
    response_code = "200"
    name, password = [params["name"], params["password"]]
    if name && password
      response = User.create(name: name, password: password, settings: self.settings, message_ids: self.message_ids, message_count: self.message_count)
    elsif name
      response = User.create(name: name, password: self.password, settings: self.settings, message_ids: self.message_ids, message_count: self.message_count)
    elsif password
      self.password = params["password"]
      response = self
    else
      response = "parameter not found"
      response_code = "404"
    end
    self.save
    [response, response_code]
  end

  def current_chatrooms
    response_code = "200"
    current_chatrooms = []
    all_chatrooms = Chatroom.all
    all_chatrooms.each do |chatroom|
      current_users, dummy = chatroom.get_current_users
      current_users.each do |user|
        if user[:name] == self.name
          entry_hash = {}
          entry_hash[:name] = chatroom.name
          entry_hash[:message_count] = user[:message_count]
          current_chatrooms << entry_hash
        end
      end
    end
    [current_chatrooms, response_code]
  end

  def logout
    response_code = "200"
    current_chatrooms, dummy = self.current_chatrooms
    current_chatrooms.each do |chatroom|
      chatroom_inst = Chatroom.find_by(name: chatroom[:name])
      chatroom_inst.leave(self.id)
    end
    [current_chatrooms, response_code]
  end

  def name_taken?(name)
    User.where(name: name).size > 0 ? true : false
  end

  def update_message_history(message_id)
    self.message_count += 1
    self.message_ids += message_id.to_s + "+"
    self.save
  end

  def settings_add(settings)
    self.settings += settings + "+"
    self.save
    [self, "200"]
  end

  def settings_delete(settings)
    response_code = "200"
    settings_array = self.settings.split("+")
    if settings_array.include?(settings)
      settings_array.delete(settings)
      if settings_array.size == 0
        self.settings = ""
      else
        self.settings = settings_array.join("+") + "+"
      end
      self.save
      response = self
    else
      response = "setting not found"
      response_code = "404"
    end
    [response, response_code]
  end

  def get_message_history
    response_code = "200"
    message_history = {}
    message_history[:body] = []
    message_history[:timestamp] = []
    message_history[:chatroom] = []
    message_ids = self.message_ids.split("+")
    message_ids.map! { |id| id = id.to_i }
    messages = Message.where(id: message_ids)
    messages.each do |message|
      message_history[:body] << message.body
      message_history[:timestamp] << message.created_at
      message_history[:chatroom] << Chatroom.find(message.chatroom_id).name
    end
    [message_history, response_code]
  end

  def get_leaderboard(timespan = 3600 * 4)
    current_time = Time.new
    cutoff_time = current_time - timespan
    response_code = "200"
    response = {}
    response[:leaderboard] = []
    response[:recent_users] = []

    top_users = User.order(message_count: :desc).limit(10)
    top_users.each do |top_user|
      entry = {}
      entry[:user_name] = top_user.name
      entry[:message_count] = top_user.message_count
      response[:leaderboard] << entry
    end
    recent_messages = Message.where("created_at > ?", cutoff_time).order(created_at: :desc)
    recent_ids = []
    recent_messages.each do |recent_message|
      recent_ids << recent_message.user_id unless recent_ids.include?(recent_message.user_id)
    end
    recent_users = User.where(id: recent_ids)
    recent_users.each do |recent_user|
      response[:recent_users] << recent_user.name
    end
    [response, response_code]
  end
end

