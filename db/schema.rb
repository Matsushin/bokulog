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

ActiveRecord::Schema.define(version: 20141031040013) do

  create_table "books", force: true do |t|
    t.string   "asin",          default: "", null: false
    t.string   "title"
    t.string   "author"
    t.string   "price"
    t.string   "manufacturer"
    t.string   "image"
    t.date     "publicated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["asin"], name: "index_books_on_asin", unique: true, using: :btree

  create_table "items", force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id", default: 0, null: false
    t.integer  "rank",        default: 0, null: false
    t.integer  "status",      default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "book_id"
    t.string   "review"
  end

  add_index "items", ["user_id"], name: "index_items_on_user_id", using: :btree

  create_table "tags", force: true do |t|
    t.integer  "item_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["item_id"], name: "index_tags_on_item_id", using: :btree

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
    t.string   "uid",                    default: "", null: false
    t.string   "provider",               default: "", null: false
    t.string   "username"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
