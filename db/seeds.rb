admin = User.create(name: "admin", password: "admin")
chatbot = User.create(name: "chatbot", password: "chatbot")
Chatroom.create(name: "General Chat")
general_chat = Chatroom.first
general_chat.join(admin.id)
general_chat.join(chatbot.id)
