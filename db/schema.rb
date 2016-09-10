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

ActiveRecord::Schema.define(version: 20160909103131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "grammar_lists", force: :cascade do |t|
    t.text     "content1"
    t.text     "content2"
    t.text     "content3"
    t.boolean  "show",       default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "lesson"
  end

  create_table "grammars", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "lesson",     default: ""
    t.text     "urls",       default: [],              array: true
    t.integer  "number",     default: 0
  end

  create_table "kanji_examples", force: :cascade do |t|
    t.string   "name",       default: ""
    t.string   "name_jp",    default: ""
    t.string   "mean",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "kanji_practises", force: :cascade do |t|
    t.string   "name",       default: ""
    t.string   "cn_name",    default: ""
    t.text     "elements",   default: [],              array: true
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "kanjis", force: :cascade do |t|
    t.string   "name"
    t.string   "mean"
    t.string   "onyomi"
    t.string   "kunjomi"
    t.string   "romaji"
    t.text     "explain"
    t.integer  "times",      default: 0
    t.text     "vn_mean"
    t.string   "image"
    t.string   "radical"
    t.string   "stroke"
    t.string   "elements"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "example_tb"
    t.string   "level"
    t.string   "r_type",     default: ""
  end

  create_table "radicals", force: :cascade do |t|
    t.string   "name"
    t.string   "mean"
    t.integer  "times",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "china"
  end

  create_table "readers", force: :cascade do |t|
    t.string   "lesson"
    t.text     "url"
    t.string   "name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "audio_url",  default: ""
    t.boolean  "show",       default: true
  end

  create_table "sentences", force: :cascade do |t|
    t.string   "content"
    t.string   "hiragana"
    t.string   "mean"
    t.string   "lesson"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.integer  "value",      default: 0
    t.string   "name",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "shadows", force: :cascade do |t|
    t.string   "question"
    t.string   "answer"
    t.integer  "session",         default: 0
    t.string   "question_romaji"
    t.string   "answer_romaji"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "words", force: :cascade do |t|
    t.string   "name"
    t.string   "romanji"
    t.string   "mean"
    t.string   "name_jp"
    t.integer  "times"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "lesson"
    t.string   "kanji"
    t.string   "kanji_note"
    t.string   "hint"
    t.boolean  "learned",    default: false
    t.boolean  "show",       default: false
    t.string   "vn_mean",    default: ""
    t.string   "cn_mean"
    t.boolean  "hard",       default: false
  end

end
