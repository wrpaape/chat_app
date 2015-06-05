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
    current_time = Time.new
    cutoff_time = current_time - timespan
    response_code = "200"
    leaderboard = {}
    leaderboard[:user_name] = []
    leaderboard[:message_count] = []
    leaderboard[:recent_users] = []
    top_users = User.order(:message_count).limit(10)
    top_users.each do |top_user|
      leaderboard[:user_name] << top_user.name
      leaderboard[:message_count] << top_user.message_count
    end
    recent_messages = Message.where("created_at > ?", cutoff_time).order(created_at: :desc)
    recent_ids = []
    recent_messages.each do |recent_message|
      recent_ids << recent_message.user_id unless recent_ids.include?(recent_message.user_id)
    end
    recent_users = User.where(id: recent_ids)
    recent_users.each do |recent_user|
      leaderboard[:recent_users] << recent_user.name
    end
    [leaderboard, response_code]
  end
end

