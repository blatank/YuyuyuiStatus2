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

ActiveRecord::Schema.define(version: 2020_06_04_125151) do

  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "mean"
    t.index ["name"], name: "index_colors_on_name", unique: true
  end

  create_table "hero_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_hero_types_on_name", unique: true
  end

  create_table "heros", force: :cascade do |t|
    t.string "name"
    t.integer "hero_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "filename", default: "hero"
    t.string "icon_url", default: ""
    t.index ["hero_type_id"], name: "index_heros_on_hero_type_id"
    t.index ["name"], name: "index_heros_on_name", unique: true
  end

  create_table "ssrs", force: :cascade do |t|
    t.string "name"
    t.integer "color_id"
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
    t.string "image_url", default: ""
    t.index ["hero_id"], name: "index_ssrs_on_hero_id"
    t.index ["name", "hero_id"], name: "index_ssrs_on_name_and_hero_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "heros", "hero_types"
  add_foreign_key "ssrs", "heros"
end
