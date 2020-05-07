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

ActiveRecord::Schema.define(version: 2020_05_07_005400) do

  create_table "hero_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "heros", force: :cascade do |t|
    t.string "name"
    t.string "hero_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ssrs", force: :cascade do |t|
    t.string "name"
    t.integer "color"
    t.string "rare"
    t.integer "hp"
    t.integer "atk"
    t.integer "stamina"
    t.integer "speed"
    t.integer "crt"
    t.integer "cost"
    t.integer "sp"
    t.integer "sp_ratio"
    t.integer "sp_atk"
    t.integer "hero_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hero_id"], name: "index_ssrs_on_hero_id"
  end

  add_foreign_key "ssrs", "heros"
end
