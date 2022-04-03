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

ActiveRecord::Schema[7.0].define(version: 2022_04_03_174818) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "access_privileges", force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "privilege_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["privilege_id"], name: "index_access_privileges_on_privilege_id"
    t.index ["profile_id"], name: "index_access_privileges_on_profile_id"
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

  create_table "menu_accesses", force: :cascade do |t|
    t.bigint "menus_id"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menus_id"], name: "index_menu_accesses_on_menus_id"
    t.index ["profile_id"], name: "index_menu_accesses_on_profile_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "title"
    t.string "link_to"
    t.boolean "hasSubMenu"
    t.boolean "isRoot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.index ["account_id"], name: "index_menus_on_account_id"
  end

  create_table "module_apps", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "optometric_histories", force: :cascade do |t|
    t.string "av_od_sc"
    t.string "av_oi_sc"
    t.string "av_od_cc"
    t.string "av_oi_cc"
    t.string "ph_od"
    t.string "ph_oi"
    t.string "k_od"
    t.string "k_oi"
    t.string "ret_od"
    t.string "ret_oi"
    t.string "rx_sph_od"
    t.string "rx_sph_oi"
    t.string "rx_cyl_od"
    t.string "rx_cyl_oi"
    t.string "rx_eje_od"
    t.string "rx_eje_oi"
    t.string "rx_dip_od"
    t.string "rx_dip_oi"
    t.string "mot_ocular"
    t.string "cover_test"
    t.string "kappa_od"
    t.string "kappa_oi"
    t.string "hirschberg"
    t.string "rpupilares_fotom"
    t.string "rpupilares_consensual"
    t.string "rpupilares_acomodativo"
    t.string "dnp_od"
    t.string "dnp_oi"
    t.string "av_od"
    t.string "av_oi"
    t.string "a_v_ao_od"
    t.string "a_v_ao_oi"
    t.string "cerca_add_od"
    t.string "cerca_add_oi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "people_id", null: false
    t.index ["people_id"], name: "index_optometric_histories_on_people_id"
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

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "doc_id"
    t.string "address"
    t.string "cell_phone"
    t.string "contact_phone"
    t.integer "district"
    t.integer "province"
    t.integer "deparment"
    t.integer "country"
    t.string "nationality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.string "ocupation"
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
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_product_categories_on_account_id"
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
    t.bigint "account_id", null: false
    t.string "slug_collection"
    t.index ["account_id"], name: "index_products_on_account_id"
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles_menu_accesses", force: :cascade do |t|
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
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_roles_on_account_id"
    t.index ["profile_id"], name: "index_roles_on_profile_id"
  end

  create_table "sub_menus", force: :cascade do |t|
    t.string "title"
    t.string "link_to"
    t.boolean "hasSubMenu"
    t.bigint "menus_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menus_id"], name: "index_sub_menus_on_menus_id"
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

  add_foreign_key "access_privileges", "privileges"
  add_foreign_key "access_privileges", "profiles"
  add_foreign_key "accounts", "organizations", column: "organizations_id"
  add_foreign_key "jobs", "job_organizations"
  add_foreign_key "menu_accesses", "menus", column: "menus_id"
  add_foreign_key "menu_accesses", "profiles"
  add_foreign_key "menus", "accounts"
  add_foreign_key "optometric_histories", "people", column: "people_id"
  add_foreign_key "product_categories", "accounts"
  add_foreign_key "product_category_images", "product_categories", column: "product_categories_id"
  add_foreign_key "products", "accounts"
  add_foreign_key "products", "product_categories"
  add_foreign_key "roles", "accounts"
  add_foreign_key "sub_menus", "menus", column: "menus_id"
end
