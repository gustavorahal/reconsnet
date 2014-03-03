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

ActiveRecord::Schema.define(version: 20140227221736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "eventos", force: true do |t|
    t.string   "nome",       null: false
    t.string   "descricao"
    t.string   "tipo"
    t.datetime "inicio",     null: false
    t.datetime "fim",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eventos", ["nome"], name: "index_eventos_on_nome", using: :btree

  create_table "identities", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participacoes", force: true do |t|
    t.integer  "evento_id",  null: false
    t.integer  "pessoa_id",  null: false
    t.string   "tipo",       null: false
    t.string   "status",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participacoes", ["evento_id"], name: "index_participacoes_on_evento_id", using: :btree
  add_index "participacoes", ["pessoa_id"], name: "index_participacoes_on_pessoa_id", using: :btree

  create_table "pessoas", force: true do |t|
    t.string   "nome",                      null: false
    t.string   "sexo",            limit: 1
    t.string   "email"
    t.date     "data_nascimento"
    t.string   "tel_resid",                              array: true
    t.string   "tel_cel",                                array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pessoas", ["nome"], name: "index_pessoas_on_nome", unique: true, using: :btree

  create_table "usuarios", force: true do |t|
    t.string   "nome"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
