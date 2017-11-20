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

ActiveRecord::Schema.define(version: 20171120162006) do

  create_table "admins", force: :cascade do |t|
    t.integer "user_id"
    t.string "admin_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_admins_on_user_id"
  end

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_authors_on_user_id"
  end

  create_table "blacklisted_tokens", force: :cascade do |t|
    t.string "token", null: false
    t.integer "user_id", null: false
    t.datetime "blacklisted_on", null: false
    t.index ["token"], name: "index_blacklisted_tokens_on_token"
    t.index ["user_id"], name: "index_blacklisted_tokens_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "isbn"
    t.integer "copies"
    t.text "description"
    t.integer "author_id"
    t.integer "cover_type"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", default: "Genie", null: false
    t.string "cover_image"
    t.index ["author_id"], name: "index_books_on_author_id"
  end

  create_table "borrowed_books", force: :cascade do |t|
    t.integer "user_id"
    t.integer "book_id"
    t.datetime "date_borrowed", null: false
    t.datetime "date_due", null: false
    t.boolean "return_status", default: false
    t.string "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_borrowed_books_on_book_id"
    t.index ["user_id"], name: "index_borrowed_books_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "image_url"
    t.string "contacts"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_libraries_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "library_id", null: false
    t.datetime "date_subscribed", null: false
    t.datetime "date_unsubscribed"
    t.boolean "subscription_status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["library_id"], name: "index_subscriptions_on_library_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "date_added", null: false
    t.datetime "updated_at", null: false
  end

end
