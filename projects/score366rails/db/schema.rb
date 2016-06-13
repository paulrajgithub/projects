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

ActiveRecord::Schema.define(version: 20160422004526) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "adminpack"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.text     "score"
    t.text     " "
    t.datetime "updated_at"
    t.boolean  "active"
    t.integer  "sequence"
    t.integer  "hometeamid"
    t.integer  "awayteamid"
  end

  create_table "gameweek", force: :cascade do |t|
    t.datetime "updated_at"
    t.datetime "day"
    t.boolean  "active"
    t.integer  "sequence"
    t.integer  "week"
  end

  create_table "matches", force: :cascade do |t|
    t.text     "score"
    t.datetime "updated_at"
    t.boolean  "active"
    t.integer  "sequence"
    t.integer  "hometeamid"
    t.integer  "awayteamid"
    t.integer  "homeuserid"
    t.integer  "awayuserid"
  end

  create_table "teamgames", force: :cascade do |t|
    t.datetime "updated_at"
    t.boolean  "active"
    t.integer  "sequence"
  end

  create_table "teams", force: :cascade do |t|
    t.text     "name"
    t.text     "logo"
    t.text     "stadium"
    t.datetime "updated_at"
    t.boolean  "active"
    t.integer  "sequence"
  end

  create_table "teams_tournaments", force: :cascade do |t|
    t.integer "tournamentid", null: false
    t.integer "teamid",       null: false
  end

  add_index "teams_tournaments", ["teamid"], name: "index_teams_tournaments_on_teamid", using: :btree
  add_index "teams_tournaments", ["tournamentid"], name: "index_teams_tournaments_on_tournamentid", using: :btree

  create_table "tournaments", force: :cascade do |t|
    t.text     "name"
    t.text     "logo"
    t.text     "type"
    t.datetime "updated_at"
    t.boolean  "active"
    t.integer  "sequence"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_adminusers_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_adminusers_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "games", "teams", column: "awayteamid"
  add_foreign_key "games", "teams", column: "hometeamid"
  add_foreign_key "matches", "teams", column: "awayteamid"
  add_foreign_key "matches", "teams", column: "hometeamid"
end
