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

ActiveRecord::Schema.define(version: 20140916074924) do

  create_table "companies", force: true do |t|
    t.string   "name",            limit: 100,                          null: false
    t.integer  "company_type_id",                                      null: false
    t.string   "website"
    t.string   "email",           limit: 100
    t.string   "phone",           limit: 20
    t.string   "duns_number",     limit: 20
    t.string   "address",         limit: 50
    t.string   "zip",             limit: 20
    t.string   "city",            limit: 50
    t.string   "state_abbr",      limit: 2
    t.decimal  "latitude",                    precision: 10, scale: 7
    t.decimal  "longitude",                   precision: 10, scale: 7
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "company_types", force: true do |t|
    t.string   "name_en",    limit: 50
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
