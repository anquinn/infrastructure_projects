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

ActiveRecord::Schema.define(version: 20180509202048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "title_en"
    t.string   "title_fr"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "projects_count", default: 0, null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name_en"
    t.string   "name_fr"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "region_id"
    t.integer  "projects_count", default: 0, null: false
  end

  add_index "locations", ["region_id"], name: "index_locations_on_region_id", using: :btree

  create_table "programs", force: :cascade do |t|
    t.string   "title_en"
    t.string   "title_fr"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "projects_count", default: 0, null: false
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "number"
    t.string   "title_en"
    t.string   "title_fr"
    t.decimal  "federal_contribution",               precision: 14, scale: 2
    t.decimal  "total_eligible_cost",                precision: 14, scale: 2
    t.string   "ultimate_recipient_en"
    t.string   "ultimate_recipient_fr"
    t.date     "forecasted_construction_start_date"
    t.date     "forecasted_construction_end_date"
    t.date     "approved_date"
    t.date     "construction_start_date"
    t.date     "construction_end_date"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.integer  "program_id"
    t.integer  "category_id"
    t.integer  "location_id"
    t.integer  "region_id"
  end

  add_index "projects", ["category_id"], name: "index_projects_on_category_id", using: :btree
  add_index "projects", ["location_id"], name: "index_projects_on_location_id", using: :btree
  add_index "projects", ["program_id"], name: "index_projects_on_program_id", using: :btree
  add_index "projects", ["region_id"], name: "index_projects_on_region_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "code"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "projects_count", default: 0, null: false
  end

  create_table "updates", force: :cascade do |t|
    t.integer  "record_count", default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_foreign_key "locations", "regions"
  add_foreign_key "projects", "categories"
  add_foreign_key "projects", "locations"
  add_foreign_key "projects", "programs"
  add_foreign_key "projects", "regions"
end
