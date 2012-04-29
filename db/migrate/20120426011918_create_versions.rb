class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions do |t|
      t.integer :story_id
      t.integer :version_number
      t.text :body
      t.text :diff
      t.timestamps
    end
    add_index :versions, :story_id
    add_index :versions, [:story_id, :version_number], :name => "uniq_ndx", :unique => true
  end

  def self.down
    drop_table :versions
  end
end
