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

ActiveRecord::Schema.define(version: 20150416054234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.text     "name"
    t.text     "image_path"
    t.boolean  "retired"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "garment_categories", force: :cascade do |t|
    t.integer  "garment_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "garments", force: :cascade do |t|
    t.text     "name"
    t.integer  "price"
    t.boolean  "retired",     default: false
    t.string   "image_path",  default: "garment_default.jpg"
    t.text     "description"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "seller_id"
  end

  create_table "order_garments", force: :cascade do |t|
    t.integer  "garment_id"
    t.integer  "order_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "quantity",   default: 1
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "sellers", force: :cascade do |t|
    t.string   "slug"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "store_name"
    t.text     "image_path",  default: "seller_default.jpg"
    t.text     "description"
  end

  create_table "users", force: :cascade do |t|
    t.text     "username"
    t.string   "password_digest"
    t.integer  "role",            default: 0
    t.text     "full_name"
    t.string   "email"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "userable_id"
    t.string   "userable_type"
  end

  add_foreign_key "orders", "users"
end
