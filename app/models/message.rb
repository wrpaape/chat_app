require 'net/http'
require 'uri'

class Message < ActiveRecord::Base
  def get(params)
    response_code = "200"
    search_query = {}

    params.each do |k, v|
      search_query[k] = v if k == "id" || k == "user_id" || k == "body"
    end

    response = Message.where(search_query)
    response = response.first if response.size == 1

    [response, response_code]
  end

  def chatbot(user_id, command, params)
    uri = URI('https://agile-chamber-3594.herokuapp.com/messages')
    uri_leave = URI("https://agile-chamber-3594.herokuapp.com/chatrooms/#{self.chatroom_id.to_s}/leave")
    # uri = URI('http://localhost:3000/messages')
    chatbot = User.find_by(name: "chatbot")
    user = User.find(user_id)

    case command
    when "lolbomb"
      resp = "LOLO"
      num_bombs = params.first.to_i
      num_bombs.times do
        bomb = resp * rand(1..20)
        Net::HTTP.post_form(uri, 'q' => 'ruby', 'body' => bomb, 'user_id' => chatbot.id, 'chatroom_id' => self.chatroom_id)
        sleep(0.25)
        # lolbomb = Message.create(user_id: user_id, chatroom_id: chatroom_id, body: resp)
        # chatbot.update_message_history(lolbomb.id)
        # current_chatroom.new_message(chatbot, lolbomb)
      end

    when "proudmom"
      score_total = {sexual: 0, inappropriate: 0, discriminatory: 0, insult: 0, blasphemy: 0}
      disp_type = {sexual: "sexual", inappropriate: "inappropriate", discriminatory: "discriminatory", insult: "insulting", blasphemy: "blasphemous"}
      history = user.get_message_history[0][:body]
      history.each do |message|
        score = Swearjar.default.scorecard(message)
        score.each { |type, count| score_total[type.to_sym] += count }
      end

      non_zero_total = {}
      score_total.each do |type, count|
        non_zero_total[type] = count if count > 0
      end

      if non_zero_total.size.zero?
        message = "*#{user.name}* has totaled a whopping ZERO (0) offensive remarks since their account's creation.  Please inform them of their welcome at kidzworld.com/chat."
      else
        message = "*#{user.name}* has made "
        ind = 0
        non_zero_total.each do |type, count|
          if ind == non_zero_total.size - 1
            message += "#{count.to_s} #{disp_type[type]} "
          else
            message += "#{count.to_s} #{disp_type[type]}, "
          end
          ind += 1
          message += "and " if ind == non_zero_total.size - 1
        end
        message += "remarks since their account's creation."
      end
      Net::HTTP.post_form(uri, 'q' => 'ruby', 'body' => message, 'user_id' => chatbot.id, 'chatroom_id' => self.chatroom_id)

    when "spam"
      num_bombs = params.shift.to_i
      resp = params.join(":")
      num_bombs.times do
        Net::HTTP.post_form(uri, 'q' => 'ruby', 'body' => resp, 'user_id' => chatbot.id, 'chatroom_id' => self.chatroom_id)
        sleep(0.25)
      end
        # lolbomb = Message.create(user_id: user_id, chatroom_id: chatroom_id, body: resp)
        # chatbot.update_message_history(lolbomb.id)
        # current_chatroom.new_message(chatbot, lolbomb)

    when "kick"
      witty_retorts = ["nice try", "stop that", "*rolls eyes*", "ACCESS DENIED", "nope", "pls stop", ""]
      kickee_name = params.first
      if kickee = User.find_by(name: kickee_name)
        if user_id == "1"
          Net::HTTP.post_form(uri_leave, 'q' => 'ruby', 'user_id' => kickee.id)
          resp = "*#{kickee_name}* was kicked from #{Chatroom.find(self.chatroom_id).name}"
          Net::HTTP.post_form(uri, 'q' => 'ruby', 'body' => resp, 'user_id' => chatbot.id, 'chatroom_id' => self.chatroom_id)
        else
          resp = witty_retorts[rand(0...witty_retorts.size)]
          Net::HTTP.post_form(uri, 'q' => 'ruby', 'body' => resp, 'user_id' => chatbot.id, 'chatroom_id' => self.chatroom_id)
        end
      else
        resp = "user not found"
        Net::HTTP.post_form(uri, 'q' => 'ruby', 'body' => resp, 'user_id' => chatbot.id, 'chatroom_id' => self.chatroom_id)
      end

    when "roll"
      # outcomes = [[" _____   ", " _____   ", " _____   ", " _____   ", " _____   ", " _____   "],
      #             ["|     |  ", "| o   |  ", "| o   |  ", "| o o |  ", "| o o |  ", "| o o |  "],
      #             ["|  o  |  ", "|     |  ", "|  o  |  ", "|     |  ", "|  o  |  ", "| o o |  "],
      #             ["|     |  ", "|   o |  ", "|   o |  ", "| o o |  ", "| o o |  ", "| o o |  "],
      #             [" ¯¯¯¯¯   ", " ¯¯¯¯¯   ", " ¯¯¯¯¯   ", " ¯¯¯¯¯   ", " ¯¯¯¯¯   ", " ¯¯¯¯¯   "]]
            outcomes = [["  _____      ", "  _____      ", "  _____      ", "  _____      ", "  _____      ", "  _____      "],
                  ["|          |    ", "|  o      |    ", "|  o      |    ", "|  o  o  |    ", "|  o  o  |    ", "|  o  o  |    "],
                  ["|    o    |    ", "|          |    ", "|    o    |    ", "|          |    ", "|    o    |    ", "|  o  o  |    "],
                  ["|          |    ", "|      o  |    ", "|      o  |    ", "|  o  o  |    ", "|  o  o  |    ", "|  o  o  |    "],
                  ["  ¯¯¯¯¯      ", "  ¯¯¯¯¯      ", "  ¯¯¯¯¯      ", "  ¯¯¯¯¯      ", "  ¯¯¯¯¯      ", "  ¯¯¯¯¯      "]]
      # outcomes = ["⚀ ", "⚁ ", "⚂ ", "⚃ ", "⚄ ", "⚅ "]
      params.first.nil? ? num_dice = 1 : num_dice = params.first.to_i
      rolls = []
      num_dice.times do
        rolls << rand(0..5)
      end
      resp = ["","","","",""]
      rolls.each do |roll|
        outcomes.each.with_index do |line, index|
          resp[index] += line[roll]
        end
      end

      resp.each do |line|
        Net::HTTP.post_form(uri, 'q' => 'ruby', 'body' => line, 'user_id' => chatbot.id, 'chatroom_id' => self.chatroom_id)
      end

    when "settings"
      action = params.first
      setting = params[1]
      uri_settings = URI("https://agile-chamber-3594.herokuapp.com/users/#{user.id}/settings/#{action}")

      Net::HTTP.post_form(uri_settings, 'q' => 'ruby', 'settings' => setting)
      if action == "add"
        resp = "*#{user.name}* added the setting '#{setting}'"
      elsif action == "delete"
        resp = "*#{user.name}* added the setting '#{setting}'"
      end
        Net::HTTP.post_form(uri, 'q' => 'ruby', 'body' => resp, 'user_id' => chatbot.id, 'chatroom_id' => self.chatroom_id)
    when "cat"
      cats = ["http://i150.photobucket.com/albums/s85/michelleNpete/BaBas/awesome-beautiful-blue-eyes-cat-cute-Favimcom-110476.jpg",
              "http://i110.photobucket.com/albums/n114/corsiphoto/tumblr_m00l5xLSbi1qjc1a7o1_500.jpg",
              "http://i794.photobucket.com/albums/yy228/jade95_2010/PHOTOGRAPHY-VARIED/cat-face.jpg",
              "http://i415.photobucket.com/albums/pp236/Keefers_/Keffers%20Animals/funny-cats-a10.jpg",
              "http://i415.photobucket.com/albums/pp236/Keefers_/Keffers%20Animals/1669501g8hvdviejo.jpg",
              "http://i415.photobucket.com/albums/pp236/Keefers_/Keffers%20Animals/DSC00549.jpg",
              "http://www.thatcutesite.com/uploads/2011/03/cat_dressed_as_lion_tree.jpg"]
      resp = cats[rand(0...cats.size)]
      Net::HTTP.post_form(uri, 'q' => 'ruby', 'body' => resp, 'user_id' => chatbot.id, 'chatroom_id' => self.chatroom_id)
    end
  end

  def filter_body
    filtered_body = self.body.gsub("/me", "*#{User.find(self.user_id).name}*")
    filtered_body = self.body.gsub("the iron yard", "maker's square")
    filtered_body = self.body.gsub("justin", "aaron")
  end
end

