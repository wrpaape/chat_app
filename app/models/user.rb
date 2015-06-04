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
end

