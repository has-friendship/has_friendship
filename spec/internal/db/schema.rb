# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2014_12_02_075742) do
  create_table "friendships", force: :cascade do |t|
    t.integer "blocker_id"
    t.datetime "created_at"
    t.integer "friend_id"
    t.integer "friendable_id"
    t.string "friendable_type"
    t.integer "status"
    t.datetime "updated_at"
    t.index ["status"], name: "index_friendships_on_status"
  end

  create_table "unfriendables", force: :cascade do |t|
    t.datetime "created_at"
    t.string "name"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at"
    t.string "name"
    t.datetime "updated_at"
  end
end
