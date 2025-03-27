# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_03_27_014658) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "choices", force: :cascade do |t|
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_id", null: false
    t.string "image"
  end

  create_table "questions", force: :cascade do |t|
    t.string "content"
    t.text "explanation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "correct_image"
  end

  create_table "user_answer_maps", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "choice_id", null: false
    t.boolean "correct", default: false
    t.string "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["choice_id"], name: "index_user_answer_maps_on_choice_id"
    t.index ["question_id"], name: "index_user_answer_maps_on_question_id"
  end

  add_foreign_key "choices", "questions"
  add_foreign_key "user_answer_maps", "choices"
  add_foreign_key "user_answer_maps", "questions"
end
