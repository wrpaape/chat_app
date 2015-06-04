class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :password, null: false
      t.string :settings, default: "default"
      t.text :message_ids

      t.timestamps null: false
    end
  end
end
