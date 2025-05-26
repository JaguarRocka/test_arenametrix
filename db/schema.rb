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

ActiveRecord::Schema[8.0].define(version: 2025_05_22_203629) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.text "address"
    t.string "postal_code", null: false
    t.string "country", null: false
    t.integer "age"
    t.string "gender", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "representations", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_representations_on_event_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "representation_id", null: false
    t.bigint "seller_id", null: false
    t.datetime "reserved_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_reservations_on_customer_id"
    t.index ["representation_id"], name: "index_reservations_on_representation_id"
    t.index ["seller_id"], name: "index_reservations_on_seller_id"
  end

  create_table "sellers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "ticket_number", null: false
    t.bigint "reservation_id", null: false
    t.float "price", null: false
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_tickets_on_reservation_id"
  end

  add_foreign_key "representations", "events"
  add_foreign_key "reservations", "customers"
  add_foreign_key "reservations", "representations"
  add_foreign_key "reservations", "sellers"
  add_foreign_key "tickets", "reservations"
end
