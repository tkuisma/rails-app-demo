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

ActiveRecord::Schema.define(version: 20140916110153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "best_seller_lists", force: true do |t|
    t.string   "display_name"
    t.string   "encoded_name"
    t.date     "oldest_published_date"
    t.date     "newest_published_date"
    t.string   "update_frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "best_sellers", force: true do |t|
    t.string   "title"
    t.integer  "best_seller_list_id",            null: false
    t.text     "description"
    t.string   "author"
    t.string   "publisher"
    t.string   "primary_isbn13",      limit: 13
    t.string   "primary_isbn10",      limit: 10
    t.string   "book_image"
    t.string   "amazon_product_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name",                  limit: 100,                          null: false
    t.integer  "company_type_id",                                            null: false
    t.string   "website"
    t.string   "email",                 limit: 100
    t.string   "phone",                 limit: 20
    t.string   "duns_number",           limit: 20
    t.string   "address",               limit: 50
    t.string   "zip",                   limit: 20
    t.string   "city",                  limit: 50
    t.string   "state_abbr",            limit: 2
    t.decimal  "latitude",                          precision: 10, scale: 7
    t.decimal  "longitude",                         precision: 10, scale: 7
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "credit_rating",         limit: 3
    t.date     "credit_rating_checked"
  end

  create_table "company_types", force: true do |t|
    t.string   "name_en",    limit: 50
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_fi",    limit: 50
    t.string   "name_sv",    limit: 50
  end

end
