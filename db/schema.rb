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

ActiveRecord::Schema[7.0].define(version: 2022_03_19_102042) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "access_privileges", force: :cascade do |t|
    t.uuid "profile_id"
    t.integer "privilege_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "address"
    t.bigint "organizations_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organizations_id"], name: "index_accounts_on_organizations_id"
  end

  create_table "job_organizations", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "total_vacancies"
    t.date "application_date"
    t.date "last_application_date"
    t.integer "area"
    t.string "location"
    t.string "salary"
    t.string "external_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "job_organization_id", null: false
    t.index ["job_organization_id"], name: "index_jobs_on_job_organization_id"
  end

  create_table "module_apps", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "organization_id"
    t.string "legal_name"
    t.string "address"
    t.integer "country_code"
    t.integer "city_code"
    t.integer "province"
    t.integer "district"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "privileges", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "slug"
    t.integer "product_count"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_category_images", force: :cascade do |t|
    t.string "thumbnail"
    t.string "original"
    t.bigint "product_categories_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_categories_id"], name: "index_product_category_images_on_product_categories_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.decimal "price"
    t.boolean "published"
    t.string "description"
    t.string "slug"
    t.decimal "sale_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_category_id", null: false
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
  end

  create_table "profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_root"
    t.integer "parent_id"
    t.index ["profile_id"], name: "index_roles_on_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.bigint "account_id"
    t.boolean "isSuperAdmin"
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "accounts", "organizations", column: "organizations_id"
  add_foreign_key "jobs", "job_organizations"
  add_foreign_key "product_category_images", "product_categories", column: "product_categories_id"
  add_foreign_key "products", "product_categories"
end
