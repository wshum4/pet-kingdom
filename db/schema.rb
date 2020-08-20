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

ActiveRecord::Schema.define(version: 2020_08_20_152838) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "requests", force: :cascade do |t|
    t.bigint "owner_id"
    t.bigint "sitter_id"
    t.string "service"
    t.date "start_date"
    t.date "end_date"
    t.integer "price"
    t.string "animal"
    t.text "animal_info"
    t.boolean "housing", default: false, null: false
    t.boolean "accepted", default: false, null: false
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_requests_on_owner_id"
    t.index ["sitter_id"], name: "index_requests_on_sitter_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating", default: 0, null: false
    t.text "content"
    t.bigint "request_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["request_id"], name: "index_reviews_on_request_id"
  end

  create_table "sitter_accepted_animals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_sitter_accepted_animals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "sitter", default: false, null: false
    t.boolean "owner", default: false, null: false
    t.text "details"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "requests", "users", column: "owner_id"
  add_foreign_key "requests", "users", column: "sitter_id"
  add_foreign_key "reviews", "requests"
  add_foreign_key "sitter_accepted_animals", "users"
end
