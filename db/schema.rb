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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121124222444) do

  create_table "contributions", :force => true do |t|
    t.integer  "contributor_id",                                                :null => false
    t.date     "date",                                                          :null => false
    t.string   "payment_type"
    t.string   "reference"
    t.decimal  "amount",         :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
  end

  create_table "contributors", :force => true do |t|
    t.string   "first_name", :null => false
    t.string   "last_name",  :null => false
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",            :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "user_type",        :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
