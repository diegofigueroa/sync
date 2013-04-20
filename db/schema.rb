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

ActiveRecord::Schema.define(:version => 20130420211219) do

  create_table "github_settings", :force => true do |t|
    t.string   "client_id"
    t.string   "client_secret"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "username"
    t.string   "organization",  :default => ""
  end

  create_table "licenses", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "logs", :force => true do |t|
    t.string   "last_state"
    t.boolean  "updated",    :default => false
    t.string   "commit"
    t.integer  "project_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "synced",     :default => false
  end

  add_index "logs", ["project_id"], :name => "index_logs_on_project_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "project_url"
    t.string   "source_code_url"
    t.string   "vcs"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "repo_name"
    t.integer  "license_id"
    t.integer  "interval"
  end

end
