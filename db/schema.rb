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

ActiveRecord::Schema.define(version: 2019_01_30_114155) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email"
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token"
  end

  create_table "planes", force: :cascade do |t|
    t.string "name"
    t.string "origin"
    t.string "destination"
    t.string "plane_type"
    t.date "date"
    t.time "plane_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seat_categories", force: :cascade do |t|
    t.bigint "plane_id"
    t.string "name"
    t.integer "number_of_seat_in_row"
    t.integer "number_of_rows"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plane_id"], name: "index_seat_categories_on_plane_id"
  end

  create_table "seats", force: :cascade do |t|
    t.bigint "plane_id"
    t.bigint "seat_category_id"
    t.string "seat_number"
    t.string "pnr"
    t.boolean "is_booked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plane_id"], name: "index_seats_on_plane_id"
    t.index ["seat_category_id"], name: "index_seats_on_seat_category_id"
  end

  create_table "user_seats", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "seat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seat_id"], name: "index_user_seats_on_seat_id"
    t.index ["user_id"], name: "index_user_seats_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.date "date_of_birth"
    t.string "gener"
    t.string "phone_number"
    t.string "email"
    t.string "adult_count"
    t.string "child_count"
    t.string "infant_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
