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

ActiveRecord::Schema[8.1].define(version: 2026_11_01_133025) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "attempts", force: :cascade do |t|
    t.string "answer"
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.bigint "question_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["correct"], name: "index_attempts_on_correct"
    t.index ["question_id"], name: "index_attempts_on_question_id"
    t.index ["user_id", "created_at"], name: "index_attempts_on_user_id_and_created_at"
    t.index ["user_id", "question_id"], name: "index_attempts_on_user_id_and_question_id"
    t.index ["user_id"], name: "index_attempts_on_user_id"
  end

  create_table "exam_boards", force: :cascade do |t|
    t.string "acronym"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["acronym"], name: "index_exam_boards_on_acronym"
    t.index ["name"], name: "index_exam_boards_on_name", unique: true
  end

  create_table "exams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "exam_board_id", null: false
    t.bigint "institution_id", null: false
    t.integer "level", default: 0, null: false
    t.string "name", null: false
    t.bigint "position_id", null: false
    t.datetime "updated_at", null: false
    t.integer "year", null: false
    t.index ["exam_board_id", "institution_id", "position_id", "year"], name: "index_exams_on_main_filters"
    t.index ["exam_board_id"], name: "index_exams_on_exam_board_id"
    t.index ["institution_id"], name: "index_exams_on_institution_id"
    t.index ["position_id"], name: "index_exams_on_position_id"
    t.index ["year"], name: "index_exams_on_year"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "acronym"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["acronym"], name: "index_institutions_on_acronym"
    t.index ["name"], name: "index_institutions_on_name", unique: true
  end

  create_table "positions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_positions_on_name", unique: true
  end

  create_table "question_alternatives", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "letter", limit: 2, null: false
    t.bigint "question_id", null: false
    t.text "text", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id", "letter"], name: "index_question_alternatives_on_question_id_and_letter", unique: true
    t.index ["question_id"], name: "index_question_alternatives_on_question_id"
  end

  create_table "question_topics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "question_id", null: false
    t.bigint "topic_id", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id", "topic_id"], name: "index_question_topics_on_question_id_and_topic_id", unique: true
    t.index ["question_id"], name: "index_question_topics_on_question_id"
    t.index ["topic_id"], name: "index_question_topics_on_topic_id"
  end

  create_table "questions", force: :cascade do |t|
    t.boolean "annulled", default: false, null: false
    t.string "correct_answer"
    t.datetime "created_at", null: false
    t.integer "difficulty", default: 0, null: false
    t.bigint "exam_id", null: false
    t.integer "modality", default: 0, null: false
    t.integer "number"
    t.boolean "outdated", default: false, null: false
    t.text "statement", null: false
    t.integer "status", default: 0, null: false
    t.bigint "subject_id", null: false
    t.datetime "updated_at", null: false
    t.index ["annulled"], name: "index_questions_on_annulled"
    t.index ["difficulty"], name: "index_questions_on_difficulty"
    t.index ["exam_id", "number"], name: "index_questions_on_exam_id_and_number", unique: true
    t.index ["exam_id"], name: "index_questions_on_exam_id"
    t.index ["modality"], name: "index_questions_on_modality"
    t.index ["outdated"], name: "index_questions_on_outdated"
    t.index ["status"], name: "index_questions_on_status"
    t.index ["subject_id"], name: "index_questions_on_subject_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_subjects_on_name", unique: true
  end

  create_table "topics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "parent_id"
    t.bigint "subject_id", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_topics_on_parent_id"
    t.index ["subject_id", "name", "parent_id"], name: "index_topics_on_subject_id_and_name_and_parent_id", unique: true
    t.index ["subject_id"], name: "index_topics_on_subject_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attempts", "questions"
  add_foreign_key "attempts", "users"
  add_foreign_key "exams", "exam_boards"
  add_foreign_key "exams", "institutions"
  add_foreign_key "exams", "positions"
  add_foreign_key "question_alternatives", "questions"
  add_foreign_key "question_topics", "questions"
  add_foreign_key "question_topics", "topics"
  add_foreign_key "questions", "exams"
  add_foreign_key "questions", "subjects"
  add_foreign_key "topics", "subjects"
  add_foreign_key "topics", "topics", column: "parent_id"
end
