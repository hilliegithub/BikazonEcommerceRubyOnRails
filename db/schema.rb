# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_08_174808) do
  create_table "accounts", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "primaryaddressstreet"
    t.string "primarypostalcode"
    t.string "secondaryaddressstreet"
    t.string "secondarypostalcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "primary_province_id"
    t.integer "secondary_province_id"
    t.index ["primary_province_id"], name: "index_accounts_on_primary_province_id"
    t.index ["secondary_province_id"], name: "index_accounts_on_secondary_province_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "cateogryname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.decimal "price"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.integer "product_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.date "orderdate"
    t.string "shippingAddress"
    t.string "paymentmethod"
    t.string "status"
    t.decimal "pst"
    t.decimal "gst"
    t.decimal "hst"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
    t.index ["account_id"], name: "index_orders_on_account_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "productname"
    t.decimal "price"
    t.integer "amountinstock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.string "provincename"
    t.string "taxtype"
    t.decimal "pst"
    t.decimal "gst"
    t.decimal "hst"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "accounts", "provinces", column: "primary_province_id"
  add_foreign_key "accounts", "provinces", column: "secondary_province_id"
end
