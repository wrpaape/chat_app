class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :password, null: false
      t.string :settings, default: "censor:on+contents_timespan:c+recent_users_timespan:6+"
      t.text :message_ids, default: ""
      t.integer :message_count, default: 0

      t.timestamps null: false
    end
  end
end
