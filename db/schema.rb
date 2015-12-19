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

ActiveRecord::Schema.define(version: 20151219044830) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignment_backups", force: :cascade do |t|
    t.integer "user_id"
    t.text    "backup"
  end

  add_index "assignment_backups", ["user_id"], name: "index_assignment_backups_on_user_id", using: :btree

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "title",            limit: 255
    t.datetime "completed_at"
    t.datetime "started_at"
    t.integer  "current_node_id"
    t.text     "description"
    t.string   "temp_id",          limit: 255
    t.text     "public_url_token"
    t.boolean  "visible",                      default: false
  end

  add_index "assignments", ["current_node_id"], name: "index_assignments_on_current_node_id", using: :btree
  add_index "assignments", ["project_id", "user_id"], name: "index_assignments_on_project_id_and_user_id", unique: true, using: :btree
  add_index "assignments", ["user_id", "project_id"], name: "index_assignments_on_user_id_and_project_id", unique: true, using: :btree

  create_table "classrooms", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "domain_id"
    t.text     "description"
    t.string   "group_key",   limit: 255
  end

  add_index "classrooms", ["domain_id"], name: "index_classrooms_on_domain_id", using: :btree

  create_table "classrooms_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "classroom_id"
  end

  add_index "classrooms_users", ["classroom_id", "user_id"], name: "index_classrooms_users_on_classroom_id_and_user_id", unique: true, using: :btree
  add_index "classrooms_users", ["user_id", "classroom_id"], name: "index_classrooms_users_on_user_id_and_classroom_id", unique: true, using: :btree

  create_table "contexts", force: :cascade do |t|
    t.text     "title"
    t.text     "url"
    t.text     "provider"
    t.json     "embedly_object"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "favicon_url"
  end

  create_table "domain_admin_roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "domain_id"
  end

  add_index "domain_admin_roles", ["domain_id"], name: "index_domain_admin_roles_on_domain_id", using: :btree
  add_index "domain_admin_roles", ["user_id"], name: "index_domain_admin_roles_on_user_id", using: :btree

  create_table "domains", force: :cascade do |t|
    t.string   "domain",      limit: 255
    t.datetime "imported_at"
    t.boolean  "importing"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "domains", ["domain"], name: "index_domains_on_domain", using: :btree

  create_table "nodes", force: :cascade do |t|
    t.integer  "assignment_id"
    t.integer  "user_id"
    t.integer  "parent_id"
    t.text     "url",                                         null: false
    t.text     "title"
    t.datetime "arrived_at"
    t.datetime "departed_at"
    t.boolean  "idle",                        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "x"
    t.float    "y"
    t.integer  "rank",                        default: 0
    t.string   "temp_id",         limit: 255
    t.integer  "context_id"
    t.boolean  "redirect"
    t.text     "redirected_from"
  end

  add_index "nodes", ["assignment_id"], name: "index_nodes_on_assignment_id", using: :btree
  add_index "nodes", ["context_id"], name: "index_nodes_on_context_id", using: :btree
  add_index "nodes", ["parent_id"], name: "index_nodes_on_parent_id", using: :btree
  add_index "nodes", ["user_id"], name: "index_nodes_on_user_id", using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id",             null: false
    t.integer  "application_id",                null: false
    t.string   "token",             limit: 255, null: false
    t.integer  "expires_in",                    null: false
    t.text     "redirect_uri",                  null: false
    t.datetime "created_at",                    null: false
    t.datetime "revoked_at"
    t.string   "scopes",            limit: 255
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             limit: 255, null: false
    t.string   "refresh_token",     limit: 255
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",                    null: false
    t.string   "scopes",            limit: 255
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",         limit: 255,                 null: false
    t.string   "uid",          limit: 255,                 null: false
    t.string   "secret",       limit: 255,                 null: false
    t.text     "redirect_uri",                             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "scopes",       limit: 255, default: "",    null: false
    t.boolean  "trusted",                  default: false
    t.integer  "owner_id"
    t.string   "owner_type"
  end

  add_index "oauth_applications", ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type", using: :btree
  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "org_units", force: :cascade do |t|
    t.integer  "domain_id"
    t.string   "name",                 limit: 255
    t.string   "org_unit_path",        limit: 255
    t.string   "parent_org_unit_path", limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "description"
    t.integer  "classroom_id"
    t.datetime "due_at"
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["classroom_id"], name: "index_projects_on_classroom_id", using: :btree

  create_table "trailblazer_admins", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid",                    limit: 255
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255
    t.string   "access_token",           limit: 255
    t.datetime "token_expires"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                              default: false
    t.boolean  "active",                             default: false
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "gender",                 limit: 255
    t.text     "image"
    t.string   "google_profile",         limit: 255
    t.string   "org_unit_path",          limit: 255
    t.integer  "org_unit_id"
    t.integer  "domain_id"
    t.boolean  "teacher",                            default: false
    t.string   "password_digest",        limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "last_email",             limit: 255
    t.datetime "last_confirmed_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["domain_id"], name: "index_users_on_domain_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["org_unit_id"], name: "index_users_on_org_unit_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
