class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string  :url
      t.string  :title
      t.string  :section
      t.string  :type
      t.string  :byline
      t.datetime :post_created
      t.datetime :post_updated
      t.datetime :post_published
      t.text    :tags
      t.boolean :allow_comments
      t.boolean :updated
      t.timestamps
    end
    add_index :stories, :url, :unique => true
    add_index :stories, :created_at
    add_index :stories, :updated_at
    add_index :stories, :updated
  end

  def self.down
    drop_table :stories
  end
end
