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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121019092129) do

  create_table "pinnames", :force => true do |t|
    t.string   "base"
    t.string   "offset"
    t.string   "subindex"
    t.string   "ord"
    t.string   "pinyin"
    t.string   "name_word"
    t.string   "name_word_abbrev"
    t.string   "part_of_speech"
    t.string   "graph_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "pinnames", ["base"], :name => "index_pinnames_on_base"
  add_index "pinnames", ["name_word"], :name => "index_pinnames_on_name_word"
  add_index "pinnames", ["name_word_abbrev"], :name => "index_pinnames_on_name_word_abbrev"
  add_index "pinnames", ["offset"], :name => "index_pinnames_on_offset"
  add_index "pinnames", ["part_of_speech"], :name => "index_pinnames_on_part_of_speech"
  add_index "pinnames", ["pinyin"], :name => "index_pinnames_on_pinyin"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
