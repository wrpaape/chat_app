class CreateChatrooms < ActiveRecord::Migration
  def change
    create_table :chatrooms do |t|
      t.text :user_ids
      t.text :message_ids

      t.timestamps null: false
    end
  end
end
