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
    uri = URI('https://young-spire-1181.herokuapp.com/messages')
    # uri = URI('http://localhost:3000/messages')
    chatbot = User.find_by(name: "chatbot")
    user = User.find(user_id)

    case command
    when "lolbomb"
      resp = "LOLOLOLOLOLOLOL"
      num_bombs = params.to_i
      num_bombs.times do
        Net::HTTP.post_form(uri, 'q' => 'ruby', 'body' => resp, 'user_id' => chatbot.id, 'chatroom_id' => self.chatroom_id)
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
        message = "*#{user.name}* has totaled a whopping ZERO (0) offensive remarks since their account's creation.  Please inform them of their welcome at www.kidzworld.com/chat"
      else
        message = "*#{user.name}* has made "
        ind = 0
        non_zero_total.each do |type, count|
          message += "#{count.to_s} #{disp_type[type]} "
          ind += 1
          message += "and " if ind == non_zero_total.size - 1
        end
        message += "remarks."
      end

      Net::HTTP.post_form(uri, 'q' => 'ruby', 'body' => message, 'user_id' => chatbot.id, 'chatroom_id' => self.chatroom_id)
    end
  end

  def filter_body
    filtered_body = self.body.gsub("/me", "*#{User.find(self.user_id).name}*")
  end
end

