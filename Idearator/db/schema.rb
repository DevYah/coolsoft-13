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

ActiveRecord::Schema.define(:version => 20130405160633) do

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "num_likes",  :default => 0
    t.integer  "user_id"
    t.integer  "idea_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "committees_tags", :id => false, :force => true do |t|
    t.integer "committee_id"
    t.integer "tag_id"
  end

  create_table "idea_notifications", :force => true do |t|
    t.string   "type"
    t.integer  "idea_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "idea_notifications", ["idea_id"], :name => "index_idea_notifications_on_idea_id"
  add_index "idea_notifications", ["user_id"], :name => "index_idea_notifications_on_user_id"

  create_table "idea_notifications_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "idea_notification_id"
    t.boolean "read",                 :default => false
  end

  create_table "ideas", :force => true do |t|
    t.string   "title",          :limit => 100,                    :null => false
    t.string   "description",                                      :null => false
    t.string   "problem_solved",                                   :null => false
    t.integer  "num_votes",                     :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.boolean  "approved",                      :default => false
    t.integer  "committee_id"
    t.boolean  "archive_status",                :default => false
  end

  create_table "ideas_tags", :id => false, :force => true do |t|
    t.integer "idea_id"
    t.integer "tag_id"
  end

  create_table "inviteds", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "admin_id"
  end

  create_table "likes", :id => false, :force => true do |t|
    t.integer "comment_id"
    t.integer "user_id"
  end

  create_table "ratings", :force => true do |t|
    t.string   "name"
    t.integer  "value"
    t.integer  "idea_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tag_connections", :id => false, :force => true do |t|
    t.integer "tag_a_id", :null => false
    t.integer "tag_b_id", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "thresholds", :force => true do |t|
    t.integer  "threshold"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_notifications", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_notifications", ["user_id"], :name => "index_user_notifications_on_user_id"

  create_table "user_notifications_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "user_notification_id"
    t.boolean "read",                 :default => false
  end

  create_table "user_ratings", :id => false, :force => true do |t|
    t.string   "name"
    t.integer  "value"
    t.integer  "user_id"
    t.integer  "rating_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                        :limit => 100,                    :null => false
    t.string   "password"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.date     "date_of_birth"
    t.string   "gender",                       :limit => 1
    t.text     "about_me"
    t.boolean  "recieve_vote_notification",                   :default => true
    t.boolean  "recieve_comment_notification",                :default => true
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
    t.string   "type"
    t.boolean  "active",                                      :default => true
    t.boolean  "banned",                                      :default => false
    t.string   "encrypted_password",                          :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                               :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :id => false, :force => true do |t|
    t.integer "idea_id"
    t.integer "user_id"
  end

end
