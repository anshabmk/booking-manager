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

ActiveRecord::Schema.define(version: 2020_02_25_101740) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bill_amounts", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "bill_id"
    t.float "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "token"
    t.index ["bill_id"], name: "index_bill_amounts_on_bill_id"
    t.index ["player_id"], name: "index_bill_amounts_on_player_id"
    t.index ["token"], name: "index_bill_amounts_on_token", unique: true
  end

  create_table "bills", force: :cascade do |t|
    t.date "from_date"
    t.date "to_date"
    t.float "fee_per_game"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "games", force: :cascade do |t|
    t.date "played_on"
    t.integer "time_slot", default: 2000
    t.integer "duration", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "games_players", id: false, force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "player_id"
    t.index ["game_id"], name: "index_games_players_on_game_id"
    t.index ["player_id"], name: "index_games_players_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "mobile_number"
    t.string "email_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
