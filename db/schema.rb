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

ActiveRecord::Schema.define(version: 20151217063847) do

  create_table "ping_aggregates", force: :cascade do |t|
    t.string   "origin",              limit: 255
    t.datetime "hourly"
    t.integer  "transfer_time_sum",   limit: 4,   default: 0
    t.integer  "transfer_time_count", limit: 4,   default: 0
    t.integer  "transfer_time_avg",   limit: 4
    t.integer  "lock_version",        limit: 4,   default: 0
  end

  add_index "ping_aggregates", ["origin", "hourly"], name: "index_ping_aggregates_on_origin_and_hourly", unique: true, using: :btree

  create_table "pings", force: :cascade do |t|
    t.string   "origin",              limit: 255
    t.integer  "name_lookup_time_ms", limit: 4
    t.integer  "connect_time_ms",     limit: 4
    t.integer  "transfer_time_ms",    limit: 4
    t.integer  "total_time_ms",       limit: 4
    t.datetime "created_at"
    t.integer  "status",              limit: 4
  end

  add_index "pings", ["origin"], name: "index_pings_on_origin", using: :btree

end
