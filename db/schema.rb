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

ActiveRecord::Schema.define(:version => 20111220172823) do

  create_table "accounts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "domains", :force => true do |t|
    t.string   "address"
    t.string   "name"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.time     "last_checked",   :default => '2000-01-01 00:00:00', :null => false
    t.integer  "check_interval"
  end

  create_table "events", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_change"
    t.integer  "domain_id"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.boolean  "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["account_id"], :name => "index_memberships_on_account_id"
  add_index "memberships", ["user_id", "account_id"], :name => "index_memberships_on_user_id_and_account_id", :unique => true
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
