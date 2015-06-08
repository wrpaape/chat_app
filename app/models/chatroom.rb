class Chatroom < ActiveRecord::Base
  def get(params)
    response_code = "200"
    search_query = {}

    params.each do |k, v|
      search_query[k] = v if k == "id" || k == "name" || k == "current_users" || k == "message_count" || k == "contents"
    end

    response = Chatroom.where(search_query)
    response = response.first if response.size == 1

    [response, response_code]
  end

  def join(user_id)
    response_code = "200"
    user_name = User.find(user_id).name
    if !self.current_users.split("░").include?(user_name)
      self.user_count += 1
      self.current_users += user_name + "░"
      self.save
      [self, response_code]
    else
      ["#{user_name} has already joined #{self.name}", response_code]
    end
  end

  def leave(user_id)
    response_code = "200"
    user_name = User.find(user_id).name
    users = self.current_users.split("░")
    if users.include?(user_name)
      self.user_count -= 1
      self.save
      if self.user_count == 0
        self.current_users = ""
      else
        users.delete(user_name)
        self.current_users = users.join("░") + "░"
      end
      self.save
      [self, response_code]
    else
      ["#{user_name} is not chatting in #{self.name}", response_code]
    end
  end

  def get_contents(user_id)
    response_code = "200"
    contents = []
    user_settings = User.find(user_id).settings.split("+")
    if user_settings.include?(":a")
      recent_timespan = 0
    elsif user_settings.include?(":b")
      recent_timespan = 60
    elsif user_settings.include?(":c")
      recent_timespan = 60 * 5
    elsif user_settings.include?(":d")
      recent_timespan = 60 * 15
    elsif user_settings.include?(":e")
      recent_timespan = 60 * 60
    elsif user_settings.include?(":f")
      recent_timespan = 60 * 24 * 365
    else
      recent_timespan = 60 * 5
    end

    return [contents, response_code] if self.contents == ""
    current_time = Time.new
    cutoff_time = current_time - recent_timespan
    contents_split2 = []
    contents_split1 = self.contents.split("▓")
    contents_split1.each do |pairs_w_ids|
      contents_split2 << pairs_w_ids.split("▒")
    end

    contents_split2.each do |array|
      message_id = array[1].split("░").last.to_i
      message_time = Message.find(message_id).created_at
      next if message_time < cutoff_time
      entry_hash = {}
      entry_hash[:name] =  array[0].split("░").first
      entry_hash[:body] = array[1].split("░").first
      entry_hash[:timestamp] = message_time.strftime("%r")
      contents << entry_hash
    end

    [contents, response_code]
  end

  def filter_contents(raw_contents, user_id)
    response_code = "200"
    filtered_contents = []
    user_settings = User.find(user_id).settings.split("+")
    if user_settings.include?("censor:off")
      filtered_contents = raw_contents
    else
      raw_contents.each do |raw_entry_hash|
        entry_hash = {}
        entry_hash[:name] = Swearjar.default.censor(raw_entry_hash[:name])
        entry_hash[:body] = Swearjar.default.censor(raw_entry_hash[:body])
        entry_hash[:timestamp] = raw_entry_hash[:timestamp]
        filtered_contents << entry_hash
      end
    end

    if user_settings.include?("espanol")
      raw_contents.each do |raw_entry_hash|
        entry_hash = {}
        entry_hash[:name] = raw_entry_hash[:name]
        entry_hash[:body] = EasyTranslate.translate(raw_entry_hash[:body], :to => 'es')
        entry_hash[:timestamp] = raw_entry_hash[:timestamp]
        filtered_contents << entry_hash
      end
    end

    header = {name: "chatbot", body: "Welcome to the no fun zone!", timestamp: Message.find(1).created_at.strftime("%r")}
    filtered_contents.unshift(header) unless filtered_contents[0] == header


    [filtered_contents, response_code]
  end

  def get_current_users
    response_code = "200"
    current_chatroom_id = self.id
    response = []
    counts = []
    current_users_array = self.current_users.split("░")
    current_users = User.where(name: current_users_array)
    current_users.each do |user|
      chatroom_message_count = 0
      user_message_ids = user.message_ids.split("+")
      user_message_ids.map! { |id| id.to_i }
      user_message_ids.each do |id|
        chatroom_message_count += 1 if Message.find(id).chatroom_id == current_chatroom_id
      end
      entry_hash = {}
      entry_hash[:name] = user.name
      entry_hash[:message_count] = chatroom_message_count
      counts << chatroom_message_count
      response << entry_hash
    end

    counts.sort!.reverse!
    ranked_response = []
    counts.each do |count|
      response.each_with_index do |entry, ind|
        if entry[:message_count] == count
          ranked_response << entry
          response.delete_at(ind)
          break
        end
      end
    end

    [ranked_response, response_code]
  end

  def get_active
    response_code = "200"
    response = []
    rank_chatrooms = Chatroom.all.order(message_count: :desc)
    rank_chatrooms.each do |chatroom|
      chatroom_hash = {}
      chatroom_hash[:name] =  chatroom.name
      chatroom_hash[:message_count] = chatroom.message_count
      response << chatroom_hash
    end
    [response, response_code]
  end

  def new_message(current_user, new_message)
    response_code = "200"
    self.message_count += 1
    self.contents += current_user.name + "░" + current_user.id.to_s + "▒" + new_message[:body] + "░" + new_message[:id].to_s + "▓"
    self.save
    [self, response_code]
  end
end

