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

ActiveRecord::Schema.define(version: 20150308102932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: :cascade do |t|
    t.integer  "bid"
    t.integer  "time_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "biddee"
    t.string   "bidder"
    t.integer  "user_id"
  end

  add_index "bids", ["user_id"], name: "index_bids_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "fb_id"
    t.string   "fb_access_token"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "relationship_status"
    t.string   "venmo_access_token"
    t.string   "venmo_username"
    t.string   "name"
    t.string   "picture_url"
  end

  add_index "users", ["fb_id"], name: "index_users_on_fb_id", unique: true, using: :btree

  add_foreign_key "bids", "users"
end
