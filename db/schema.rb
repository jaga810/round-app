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

ActiveRecord::Schema.define(version: 20151015122521) do

  create_table "circles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "email"
    t.string   "remember_token"
    t.string   "group"
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.integer  "circle_id"
    t.string   "gender"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "time",          default: 0
    t.integer  "s_time",        default: 0
    t.integer  "v_time",        default: 0
    t.integer  "o_time",        default: 0
    t.integer  "duration",      default: 0
    t.string   "method"
    t.text     "played_player", default: "nil"
    t.boolean  "active",        default: true
    t.boolean  "com"
    t.text     "forbidden"
    t.string   "group"
    t.text     "past_method"
    t.text     "past_duration"
    t.string   "pre_forbidden"
  end

  create_table "practices", force: :cascade do |t|
    t.integer  "circle_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "method"
    t.integer  "man_rane"
    t.integer  "mix_rane"
    t.boolean  "active",     default: true
  end

  create_table "rounds", force: :cascade do |t|
    t.integer  "practice_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "order",       default: 1
    t.integer  "man_rane"
    t.integer  "mix_rane"
    t.text     "now_players"
  end

end
