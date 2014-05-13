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

ActiveRecord::Schema.define(version: 20140504200031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "addresses", force: true do |t|
    t.string   "line1"
    t.string   "city"
    t.string   "state_code"
    t.string   "zip"
    t.string   "country_code"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", unique: true, using: :btree

  create_table "events", force: true do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.string   "event_type"
    t.datetime "start",       null: false
    t.datetime "finish",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["name"], name: "index_events_on_name", using: :btree

  create_table "participations", force: true do |t|
    t.integer  "event_id",           null: false
    t.integer  "person_id",          null: false
    t.string   "participation_type", null: false
    t.string   "status",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participations", ["event_id"], name: "index_participations_on_event_id", using: :btree
  add_index "participations", ["person_id"], name: "index_participations_on_person_id", using: :btree

  create_table "people", force: true do |t|
    t.string   "name",             null: false
    t.string   "gender"
    t.string   "email"
    t.date     "date_of_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profession"
    t.string   "nationality"
    t.integer  "address_id"
    t.string   "landline_number"
    t.string   "mobile_number"
    t.boolean  "marketing"
    t.hstore   "marketing_optout"
  end

  add_index "people", ["name"], name: "index_people_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
