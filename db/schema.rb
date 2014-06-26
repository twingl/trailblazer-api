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

ActiveRecord::Schema.define(version: 20140625042959) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "domain_admin_roles", force: true do |t|
    t.integer "user_id"
    t.integer "domain_id"
  end

  add_index "domain_admin_roles", ["domain_id"], name: "index_domain_admin_roles_on_domain_id", using: :btree
  add_index "domain_admin_roles", ["user_id"], name: "index_domain_admin_roles_on_user_id", using: :btree

  create_table "domains", force: true do |t|
    t.string   "domain"
    t.datetime "imported"
    t.boolean  "importing"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "domains", ["domain"], name: "index_domains_on_domain", using: :btree

  create_table "users", force: true do |t|
    t.string   "uid",                            null: false
    t.string   "name"
    t.string   "email"
    t.string   "access_token"
    t.datetime "token_expires"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",          default: false
    t.boolean  "active",         default: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.text     "image"
    t.string   "google_profile"
  end

end
