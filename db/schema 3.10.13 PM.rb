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

ActiveRecord::Schema.define(:version => 20140304215337) do

  create_table "campaigns", :force => true do |t|
    t.string   "title"
    t.string   "subject"
    t.integer  "list_id",                   :limit => 255
    t.datetime "send_date"
    t.string   "send_weekday"
    t.integer  "total_recipients"
    t.integer  "successful_deliveries"
    t.integer  "soft_bounces"
    t.integer  "hard_bounces"
    t.integer  "total_bounces"
    t.integer  "times_forwarded"
    t.integer  "forwarded_opens"
    t.integer  "unique_opens"
    t.decimal  "open_rate"
    t.integer  "total_opens"
    t.integer  "unique_clicks"
    t.decimal  "click_rate"
    t.integer  "total_clicks"
    t.integer  "unsubscribes"
    t.integer  "abuse_complaints"
    t.integer  "times_liked_on_facebook"
    t.integer  "folder_id"
    t.string   "unique_id"
    t.decimal  "analytics_roi"
    t.decimal  "campaign_cost"
    t.decimal  "revenue_created"
    t.integer  "visits"
    t.integer  "new_visits"
    t.float    "pagesvisit"
    t.decimal  "bounce_rate"
    t.decimal  "goal_conversion_rate"
    t.decimal  "per_visit_goal_value"
    t.integer  "transactions"
    t.decimal  "ecommerce_conversion_rate"
    t.decimal  "per_visit_value"
    t.decimal  "average_value"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "group_campaign_id"
  end

  create_table "group_campaigns", :force => true do |t|
    t.string   "title"
    t.string   "subject"
    t.integer  "list_id",                   :limit => 255
    t.datetime "send_date"
    t.string   "send_weekday"
    t.integer  "total_recipients"
    t.integer  "successful_deliveries"
    t.integer  "soft_bounces"
    t.integer  "hard_bounces"
    t.integer  "total_bounces"
    t.integer  "times_forwarded"
    t.integer  "forwarded_opens"
    t.integer  "unique_opens"
    t.decimal  "open_rate"
    t.integer  "total_opens"
    t.integer  "unique_clicks"
    t.decimal  "click_rate"
    t.integer  "total_clicks"
    t.integer  "unsubscribes"
    t.integer  "abuse_complaints"
    t.integer  "times_liked_on_facebook"
    t.integer  "folder_id"
    t.string   "unique_id"
    t.decimal  "analytics_roi"
    t.decimal  "campaign_cost"
    t.decimal  "revenue_created"
    t.integer  "visits"
    t.integer  "new_visits"
    t.float    "pagesvisit"
    t.decimal  "bounce_rate"
    t.time     "time_on_site"
    t.decimal  "goal_conversion_rate"
    t.decimal  "per_visit_goal_value"
    t.integer  "transactions"
    t.decimal  "ecommerce_conversion_rate"
    t.decimal  "per_visit_value"
    t.decimal  "average_value"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "lists", :force => true do |t|
    t.string   "name"
    t.string   "list_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
