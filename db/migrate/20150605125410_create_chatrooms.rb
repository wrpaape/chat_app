class CreateChatrooms < ActiveRecord::Migration
  def change
    create_table :chatrooms do |t|
      t.string :name, default: ""
      t.text :current_users, default: ""
      t.integer :message_count, default: 0
      t.text :contents, default: ""

      t.timestamps null: false
    end
  end
end
