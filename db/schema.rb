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

ActiveRecord::Schema.define(version: 20130626091743) do

  create_table "facebook_page_likes", force: true do |t|
    t.integer  "page_id"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facebook_page_likes", ["page_id"], name: "index_facebook_page_likes_on_page_id"
  add_index "facebook_page_likes", ["profile_id", "page_id"], name: "page_and_profile_unique", unique: true
  add_index "facebook_page_likes", ["profile_id"], name: "index_facebook_page_likes_on_profile_id"

  create_table "facebook_pages", force: true do |t|
    t.integer  "fb_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facebook_profiles", force: true do |t|
    t.string   "name"
    t.integer  "fb_id"
    t.string   "url_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facebook_profiles", ["fb_id"], name: "index_facebook_profiles_on_fb_id", unique: true
  add_index "facebook_profiles", ["name"], name: "index_facebook_profiles_on_name"

  create_table "scheduled_page_like_checks", force: true do |t|
    t.string   "via",                   null: false
    t.integer  "attempts",              null: false
    t.integer  "remaining_attempts",    null: false
    t.integer  "wait_between_requests", null: false
    t.integer  "facebook_page_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scheduled_page_like_checks", ["facebook_page_id"], name: "index_scheduled_page_like_checks_on_facebook_page_id"

end
