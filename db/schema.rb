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

ActiveRecord::Schema.define(version: 2021_09_18_131353) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.datetime "starttime"
    t.datetime "endtime"
    t.text "description"
    t.boolean "is_allday"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["endtime"], name: "index_events_on_endtime"
    t.index ["starttime"], name: "index_events_on_starttime"
  end

  create_table "user_events", force: :cascade do |t|
    t.string "user_id", null: false
    t.bigint "event_id", null: false
    t.integer "rsvp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_user_events_on_event_id"
    t.index ["rsvp"], name: "index_user_events_on_rsvp"
    t.index ["user_id", "event_id"], name: "index_user_events_on_user_id_and_event_id", unique: true
    t.index ["user_id"], name: "index_user_events_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "user_events", "events"
  add_foreign_key "user_events", "users", primary_key: "username"
end
