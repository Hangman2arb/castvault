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

ActiveRecord::Schema[7.1].define(version: 2024_02_26_064656) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "forms", force: :cascade do |t|
    t.string "name"
    t.integer "submissions_count", default: 0
    t.integer "completions_count", default: 0
    t.jsonb "fields", default: {}
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_forms_on_user_id"
  end

  create_table "profile_tags", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_profile_tags_on_profile_id"
    t.index ["tag_id"], name: "index_profile_tags_on_tag_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.date "birthdate"
    t.string "ethnicity"
    t.string "gender"
    t.string "city"
    t.string "email"
    t.string "phone"
    t.boolean "agency", default: false
    t.string "agent_name"
    t.string "agent_email"
    t.string "agent_phone"
    t.integer "height"
    t.integer "shirt_size"
    t.integer "pants_size"
    t.integer "shoe_size"
    t.string "hair_type"
    t.string "hair_color"
    t.string "eye_color"
    t.boolean "passport", default: false
    t.boolean "driving_license", default: false
    t.text "food_allergies"
    t.string "web"
    t.string "twitter"
    t.string "facebook"
    t.string "instagram"
    t.string "tik_tok"
    t.boolean "is_an_actor", default: false
    t.json "languages", default: []
    t.json "available_for", default: []
    t.json "sports_outdoor", default: []
    t.json "sports_watersports", default: []
    t.json "sports_martial_arts", default: []
    t.json "sports_gymnastics", default: []
    t.json "sports_extreme", default: []
    t.json "sports_team", default: []
    t.json "sports_underwater", default: []
    t.json "arts_leisure_music", default: []
    t.json "arts_leisure_dance", default: []
    t.json "arts_leisure_stunt_professions", default: []
    t.json "general", default: []
    t.boolean "performing_arts", default: false
    t.boolean "tv", default: false
    t.boolean "fiction", default: false
    t.boolean "advertising", default: false
    t.bigint "form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_profiles_on_form_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 0, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "street_1"
    t.string "street_2"
    t.string "zipcode"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "vat_number"
    t.string "language"
    t.string "time_zone"
    t.boolean "terms_accepted"
    t.text "legal_text"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "period"
    t.integer "plan"
    t.string "subscription_status"
    t.datetime "subscription_ends_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "last_email_change_attempt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "forms", "users"
  add_foreign_key "profile_tags", "profiles"
  add_foreign_key "profile_tags", "tags"
end
