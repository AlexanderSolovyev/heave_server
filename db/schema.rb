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

ActiveRecord::Schema.define(version: 20181108121951) do

  create_table "goods", force: :cascade do |t|
    t.string "good_name"
    t.string "price"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goods_orders", force: :cascade do |t|
    t.string "goods_quantity"
    t.string "image_url"
    t.string "id_1c"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "good_id"
    t.index ["good_id"], name: "index_goods_orders_on_good_id"
    t.index ["order_id"], name: "index_goods_orders_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.string "bottles"
    t.string "returned_bottles"
    t.string "delivery_address"
    t.string "delivery_date"
    t.string "delivery_time"
    t.string "information"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reg_number"
    t.string "name"
    t.string "phone"
    t.boolean "confirm", default: false
    t.string "password"
  end

end
