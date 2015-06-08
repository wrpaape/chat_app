# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150608005853) do

  create_table "chatrooms", force: :cascade do |t|
    t.string   "name",          default: ""
    t.text     "current_users", default: ""
    t.integer  "user_count",    default: 0
    t.integer  "message_count", default: 0
    t.text     "contents",      default: ""
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "chatroom_id"
    t.text     "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                                                                             null: false
    t.string   "password",                                                                         null: false
    t.string   "settings",      default: "censor:on+contents_timespan:c+recent_users_timespan:6+"
    t.text     "message_ids",   default: ""
    t.integer  "message_count", default: 0
    t.datetime "created_at",                                                                       null: false
    t.datetime "updated_at",                                                                       null: false
  end

end
