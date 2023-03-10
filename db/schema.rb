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

ActiveRecord::Schema.define(version: 20_230_123_135_838) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'best_answers', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'comment_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['comment_id'], name: 'index_best_answers_on_comment_id'
    t.index ['user_id'], name: 'index_best_answers_on_user_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'comments', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'post_id', null: false
    t.string 'content', null: false
    t.integer 'status', default: 0, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['post_id'], name: 'index_comments_on_post_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'favorites', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'post_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['post_id'], name: 'index_favorites_on_post_id'
    t.index ['user_id'], name: 'index_favorites_on_user_id'
  end

  create_table 'post_categories', force: :cascade do |t|
    t.bigint 'post_id', null: false
    t.bigint 'category_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['category_id'], name: 'index_post_categories_on_category_id'
    t.index ['post_id'], name: 'index_post_categories_on_post_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'title', null: false
    t.string 'img'
    t.string 'body', null: false
    t.integer 'status', default: 0, null: false
    t.datetime 'deadline'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_posts_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.string 'crypted_password'
    t.string 'salt'
    t.integer 'role', default: 0, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  create_table 'votes', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'post_id', null: false
    t.integer 'status'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['post_id'], name: 'index_votes_on_post_id'
    t.index ['user_id'], name: 'index_votes_on_user_id'
  end

  add_foreign_key 'best_answers', 'comments'
  add_foreign_key 'best_answers', 'users'
  add_foreign_key 'comments', 'posts'
  add_foreign_key 'comments', 'users'
  add_foreign_key 'favorites', 'posts'
  add_foreign_key 'favorites', 'users'
  add_foreign_key 'post_categories', 'categories'
  add_foreign_key 'post_categories', 'posts'
  add_foreign_key 'posts', 'users'
  add_foreign_key 'votes', 'posts'
  add_foreign_key 'votes', 'users'
end
