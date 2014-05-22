# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20121024012137) do

  create_table "dummy_items", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occurro_counters", force: true do |t|
    t.integer  "countable_id"
    t.string   "countable_type"
    t.integer  "today",          default: 0, null: false
    t.integer  "yesterday",      default: 0, null: false
    t.integer  "this_week",      default: 0, null: false
    t.integer  "last_week",      default: 0, null: false
    t.integer  "this_month",     default: 0, null: false
    t.integer  "last_month",     default: 0, null: false
    t.integer  "total",          default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "occurro_counters", ["countable_type", "countable_id"], name: "countable_unq", unique: true
  add_index "occurro_counters", ["countable_type", "this_month", "last_month"], name: "countable_type_monthly"
  add_index "occurro_counters", ["countable_type", "this_week", "last_week"], name: "countable_type_weekly"
  add_index "occurro_counters", ["countable_type", "today", "yesterday"], name: "countable_type_daily"

  create_table "occurro_daily_counters", force: true do |t|
    t.integer  "countable_id"
    t.string   "countable_type"
    t.integer  "total",          default: 0, null: false
    t.date     "created_on"
    t.datetime "updated_at"
  end

  add_index "occurro_daily_counters", ["countable_type", "countable_id", "created_on"], name: "daily_counter_unq", unique: true
  add_index "occurro_daily_counters", ["countable_type", "total"], name: "daily_counter_total"

end
