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
end

