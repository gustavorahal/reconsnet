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

ActiveRecord::Schema.define(version: 20140330210756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.string   "type"
    t.datetime "start",       null: false
    t.datetime "finish",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["name"], name: "index_events_on_name", using: :btree

  create_table "participations", force: true do |t|
    t.integer  "event_id",   null: false
    t.integer  "person_id",  null: false
    t.string   "type",       null: false
    t.string   "status",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participations", ["event_id"], name: "index_participations_on_event_id", using: :btree
  add_index "participations", ["person_id"], name: "index_participations_on_person_id", using: :btree

  create_table "people", force: true do |t|
    t.string   "name",          null: false
    t.string   "gender"
    t.string   "email"
    t.date     "date_of_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["name"], name: "index_people_on_name", unique: true, using: :btree

end
