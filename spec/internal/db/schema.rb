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

ActiveRecord::Schema.define(version: 20141201035353) do

  create_table "friendables", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "friender_id"
    t.string   "friender_type"
    t.integer  "friendee_id"
    t.string   "friendee_type"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friendee_id", "friendee_type"], name: "index_friendships_on_friendee_id_and_friendee_type"
  add_index "friendships", ["friender_id", "friender_type"], name: "index_friendships_on_friender_id_and_friender_type"

  create_table "unfriendables", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
