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

ActiveRecord::Schema.define(:version => 20121211083919) do

  create_table "formulas", :force => true do |t|
    t.string   "base"
    t.string   "offset"
    t.string   "subindex"
    t.string   "iform"
    t.string   "word_form"
    t.string   "abbrev_form"
    t.string   "alpha"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "ord"
    t.string   "graph_id"
  end

  add_index "formulas", ["abbrev_form"], :name => "index_formulas_on_abbrev_form"
  add_index "formulas", ["alpha"], :name => "index_formulas_on_alpha"
  add_index "formulas", ["base"], :name => "index_formulas_on_base"
  add_index "formulas", ["graph_id"], :name => "index_formulas_on_graph_id"
  add_index "formulas", ["iform"], :name => "index_formulas_on_iform"
  add_index "formulas", ["offset"], :name => "index_formulas_on_offset"
  add_index "formulas", ["ord"], :name => "index_formulas_on_ord"
  add_index "formulas", ["subindex"], :name => "index_formulas_on_subindex"
  add_index "formulas", ["word_form"], :name => "index_formulas_on_word_form"

  create_table "links", :force => true do |t|
    t.string   "graph_id"
    t.integer  "pinname_id"
    t.string   "pinname_ord"
    t.integer  "formula_id"
    t.string   "formula_ord"
    t.string   "weight"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "links", ["formula_id"], :name => "index_links_on_formula_id"
  add_index "links", ["graph_id"], :name => "index_links_on_graph_id"
  add_index "links", ["pinname_id", "formula_id"], :name => "index_links_on_pinname_id_and_formula_id"
  add_index "links", ["pinname_id"], :name => "index_links_on_pinname_id"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

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
  add_index "pinnames", ["graph_id"], :name => "index_pinnames_on_graph_id"
  add_index "pinnames", ["name_word"], :name => "index_pinnames_on_name_word"
  add_index "pinnames", ["name_word_abbrev"], :name => "index_pinnames_on_name_word_abbrev"
  add_index "pinnames", ["offset"], :name => "index_pinnames_on_offset"
  add_index "pinnames", ["ord"], :name => "index_pinnames_on_ord"
  add_index "pinnames", ["part_of_speech"], :name => "index_pinnames_on_part_of_speech"
  add_index "pinnames", ["pinyin"], :name => "index_pinnames_on_pinyin"
  add_index "pinnames", ["subindex"], :name => "index_pinnames_on_subindex"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
