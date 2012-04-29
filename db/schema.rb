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

ActiveRecord::Schema.define(:version => 20120426011918) do

  create_table "stories", :force => true do |t|
    t.string   "url"
    t.string   "title"
    t.string   "section"
    t.string   "type"
    t.string   "byline"
    t.datetime "post_created"
    t.datetime "post_updated"
    t.datetime "post_published"
    t.text     "tags"
    t.boolean  "allow_comments"
    t.boolean  "updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stories", ["created_at"], :name => "index_stories_on_created_at"
  add_index "stories", ["updated"], :name => "index_stories_on_updated"
  add_index "stories", ["updated_at"], :name => "index_stories_on_updated_at"
  add_index "stories", ["url"], :name => "index_stories_on_url", :unique => true

  create_table "versions", :force => true do |t|
    t.integer  "story_id"
    t.integer  "version_number"
    t.text     "body"
    t.text     "diff"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["story_id", "version_number"], :name => "uniq_ndx", :unique => true
  add_index "versions", ["story_id"], :name => "index_versions_on_story_id"

end
