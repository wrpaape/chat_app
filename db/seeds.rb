admin = User.create(name: "admin", password: "admin")
Chatroom.create(name: "General Chat")
general_chat = Chatroom.first
general_chat.join(admin.id)
