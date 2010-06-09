class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :name
      t.string :path
      t.boolean :is_start
      t.integer :run_id
      t.boolean :visible
      t.integer :counter
      t.integer :upload_by_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
