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

ActiveRecord::Schema.define(version: 20151118194003) do

  create_table "installs", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "device_id",    limit: 65535
    t.string   "request_type", limit: 255
  end

  create_table "issues", force: :cascade do |t|
    t.string   "status",                    limit: 255
    t.string   "summary",                   limit: 255
    t.text     "description",               limit: 65535
    t.float    "lat",                       limit: 24
    t.float    "lng",                       limit: 24
    t.text     "address",                   limit: 65535
    t.string   "scf_image_url",             limit: 255
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.integer  "place_id",                  limit: 4
    t.integer  "geofence_radius",           limit: 4,     default: 500
    t.string   "custom_image_file_name",    limit: 255
    t.string   "custom_image_content_type", limit: 255
    t.integer  "custom_image_file_size",    limit: 4
    t.datetime "custom_image_updated_at"
    t.text     "question",                  limit: 65535
    t.text     "answer1",                   limit: 65535
    t.text     "answer2",                   limit: 65535
    t.text     "answer3",                   limit: 65535
    t.text     "answer4",                   limit: 65535
    t.text     "answer5",                   limit: 65535
    t.text     "answer6",                   limit: 65535
  end

  create_table "logs", force: :cascade do |t|
    t.integer  "issue_id",   limit: 4
    t.string   "action",     limit: 255
    t.datetime "timestamp"
    t.float    "lat",        limit: 24
    t.float    "lng",        limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "install_id", limit: 255
    t.string   "details",    limit: 255
  end

  create_table "places", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.text     "json",              limit: 65535
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "url_name",          limit: 255
    t.string   "state",             limit: 255
    t.datetime "issues_fetched_at"
    t.string   "provider",          limit: 255,   default: "seeclickfix"
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "install_id",         limit: 4
    t.integer  "issue_id",           limit: 4
    t.datetime "timestamp"
    t.string   "answer",             limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.float    "lat",                limit: 24
    t.float    "lng",                limit: 24
    t.text     "comment",            limit: 65535
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.integer  "photo_file_size",    limit: 4
    t.datetime "photo_updated_at"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "user_id",    limit: 4
    t.integer  "issue_id",   limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
