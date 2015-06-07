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

  def chatbot(chatbot_hash)
    uri = URI('https://young-spire-1181.herokuapp.com/messages')
    # uri = URI('http://localhost:3000/messages')
    chatbot = User.find_by(name: "chatbot")
    current_chatroom = Chatroom.find(self.chatroom_id)
    cmd = command.split(":").first.to_sym
    resp = chatbot_hash[cmd]

    case cmd
    when :lolbomb
      num_bombs = command.split(":")[1].to_i
      num_bombs.times do
        res = Net::HTTP.post_form(uri, 'q' => 'ruby', 'body' => resp, 'user_id' => chatbot.id, 'chatroom_id' => self.chatroom_id)
        puts res.body
        sleep(0.25)
        # lolbomb = Message.create(user_id: user_id, chatroom_id: chatroom_id, body: resp)
        # chatbot.update_message_history(lolbomb.id)
        # current_chatroom.new_message(chatbot, lolbomb)
      end
    end
  end

  def filter_body
    filtered_body = self.body.gsub("/me", User.find(self.user_id).name)
  end
end

