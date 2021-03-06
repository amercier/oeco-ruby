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

ActiveRecord::Schema.define(version: 20150120065244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "categories_projects", force: true do |t|
    t.integer  "category_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories_projects", ["category_id"], name: "index_categories_projects_on_category_id", using: :btree
  add_index "categories_projects", ["project_id"], name: "index_categories_projects_on_project_id", using: :btree

  create_table "news", force: true do |t|
    t.string   "url"
    t.string   "title"
    t.string   "summary"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "news", ["order"], name: "index_news_on_order", unique: true, using: :btree
  add_index "news", ["url"], name: "index_news_on_url", unique: true, using: :btree

  create_table "projects", force: true do |t|
    t.string   "url"
    t.string   "title"
    t.string   "summary"
    t.string   "content"
    t.boolean  "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "projects", ["url"], name: "index_projects_on_url", unique: true, using: :btree

  create_table "projects_properties", force: true do |t|
    t.integer  "project_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects_properties", ["project_id"], name: "index_projects_properties_on_project_id", using: :btree
  add_index "projects_properties", ["property_id"], name: "index_projects_properties_on_property_id", using: :btree

  create_table "properties", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "properties", ["name"], name: "index_properties_on_name", unique: true, using: :btree
  add_index "properties", ["order"], name: "index_properties_on_order", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
