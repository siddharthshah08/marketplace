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

ActiveRecord::Schema.define(version: 20171126174002) do

  create_table "bids", force: :cascade do |t|
    t.float "rate"
    t.float "bid_amount"
    t.string "rate_type"
    t.integer "buyer_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["buyer_id"], name: "index_bids_on_buyer_id"
    t.index ["project_id"], name: "index_bids_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "status"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "accepting_bids_till"
    t.integer "seller_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.binary "pq"
    t.integer "lowest_bid_id"
    t.index ["seller_id"], name: "index_projects_on_seller_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uname"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
  end

end
