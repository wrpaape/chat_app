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

  def chatbot(command, chatbot_hash)
    chatbot_hash.each { |cmd, resp| response = resp if command == cmd.to_s}

    case response
    when "lolbombx"
      response = chatbot_hash.
      num_bombs = command[8..-1].to_i
      num_bombs.times do
        lolbomb = Message.create()

      end
    end


  end
end

