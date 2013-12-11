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

ActiveRecord::Schema.define(version: 20131211034751) do

  create_table "batches", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "posted_at",  null: false
  end

  create_table "contributions", force: true do |t|
    t.integer  "contributor_id",             null: false
    t.date     "date",                       null: false
    t.string   "payment_type"
    t.string   "reference"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "status"
    t.integer  "batch_id"
    t.integer  "amount_cents",   default: 0, null: false
  end

  create_table "contributors", force: true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
    t.string   "status"
    t.string   "phone"
    t.string   "email"
    t.text     "notes"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.string   "username",         null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "user_type",        null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
