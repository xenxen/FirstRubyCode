# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_11_022507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billing_infos", force: :cascade do |t|
    t.string "doc_type"
    t.string "doc_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "buyers", force: :cascade do |t|
    t.integer "external_id"
    t.string "nickname"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.bigint "phone_id", null: false
    t.bigint "billing_info_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["billing_info_id"], name: "index_buyers_on_billing_info_id"
    t.index ["phone_id"], name: "index_buyers_on_phone_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "external_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "external_id"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "neighborhoods", force: :cascade do |t|
    t.string "external_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity"
    t.float "unit_price"
    t.float "full_unit_price"
    t.bigint "item_id", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "external_id"
    t.integer "store_id"
    t.datetime "date_created"
    t.datetime "date_closed"
    t.datetime "last_updated"
    t.float "total_amount"
    t.float "total_shipping"
    t.float "total_amount_with_shipping"
    t.float "paid_amount"
    t.datetime "expiration_date"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "shipping_id", null: false
    t.bigint "buyer_id", null: false
    t.index ["buyer_id"], name: "index_orders_on_buyer_id"
    t.index ["shipping_id"], name: "index_orders_on_shipping_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "external_id"
    t.integer "external_order_id"
    t.integer "payer_id"
    t.integer "installments"
    t.string "payment_type"
    t.string "status"
    t.float "transaction_amount"
    t.float "taxes_amount"
    t.float "shipping_cost"
    t.float "total_paid_amount"
    t.float "installment_amount"
    t.datetime "date_approved"
    t.datetime "date_created"
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string "area_code"
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "receiver_addresses", force: :cascade do |t|
    t.integer "external_id"
    t.string "address_line"
    t.string "street_name"
    t.string "street_number"
    t.string "comment"
    t.string "zip_code"
    t.string "latitude"
    t.string "longitude"
    t.string "receiver_phone"
    t.bigint "city_id", null: false
    t.bigint "state_id", null: false
    t.bigint "country_id", null: false
    t.bigint "neighborhood_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_receiver_addresses_on_city_id"
    t.index ["country_id"], name: "index_receiver_addresses_on_country_id"
    t.index ["neighborhood_id"], name: "index_receiver_addresses_on_neighborhood_id"
    t.index ["state_id"], name: "index_receiver_addresses_on_state_id"
  end

  create_table "shippings", force: :cascade do |t|
    t.integer "external_id"
    t.string "shipment_type"
    t.datetime "date_created"
    t.bigint "receiver_address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receiver_address_id"], name: "index_shippings_on_receiver_address_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "syncs", force: :cascade do |t|
    t.datetime "date_created"
    t.datetime "date_processed"
    t.string "sender_ip"
    t.text "payload"
    t.string "status"
    t.string "storeId"
    t.string "externalCode"
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_syncs_on_order_id"
  end

  add_foreign_key "buyers", "billing_infos"
  add_foreign_key "buyers", "phones"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "buyers"
  add_foreign_key "orders", "shippings"
  add_foreign_key "payments", "orders"
  add_foreign_key "receiver_addresses", "cities"
  add_foreign_key "receiver_addresses", "countries"
  add_foreign_key "receiver_addresses", "neighborhoods"
  add_foreign_key "receiver_addresses", "states"
  add_foreign_key "shippings", "receiver_addresses"
  add_foreign_key "syncs", "orders"
end
