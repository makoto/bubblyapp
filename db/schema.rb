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

ActiveRecord::Schema.define(:version => 20110315184633) do

  create_table "mentions", :force => true do |t|
    t.string   "twitter"
    t.integer  "tweet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "mentions", ["tweet_id"], :name => "index_mentions_on_tweet_id"
  add_index "mentions", ["twitter"], :name => "index_mentions_on_twitter"

  create_table "schedules", :force => true do |t|
    t.datetime "start_at"
    t.datetime "finish_at"
    t.text     "content"
    t.string   "href"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["finish_at"], :name => "index_schedules_on_finish_at"
  add_index "schedules", ["start_at"], :name => "index_schedules_on_start_at"

  create_table "speakers", :force => true do |t|
    t.string   "name"
    t.string   "twitter"
    t.integer  "schedule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "speakers", ["schedule_id"], :name => "index_speakers_on_schedule_id"
  add_index "speakers", ["twitter"], :name => "index_speakers_on_twitter"

  create_table "tweets", :force => true do |t|
    t.integer  "id_str"
    t.integer  "retweet_count"
    t.datetime "tweeted_at"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets", ["id_str"], :name => "index_tweets_on_id_str"
  add_index "tweets", ["tweeted_at"], :name => "index_tweets_on_tweeted_at"

  create_table "users", :force => true do |t|
    t.string   "twitter"
    t.integer  "mention_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
