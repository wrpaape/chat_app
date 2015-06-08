admin = User.create(name: "admin", password: "admin")
chatbot = User.create(name: "chatbot", password: "chatbot")
Chatroom.create(name: "General Chat")
general_chat = Chatroom.first
general_chat.join(admin.id)
general_chat.join(chatbot.id)
first_message = Message.create(user_id: chatbot.id, chatroom_id: general_chat.id, body: "Welcome to the no fun zone!")
filtered_body = first_message.filter_body
chatbot.update_message_history(first_message.id)
general_chat.new_message(chatbot, {id: first_message.id, body: filtered_body})
