class CreateVideocomments < ActiveRecord::Migration
  def self.up
    create_table :videocomments do |t|
      t.integer :video_id
      t.integer :user_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :videocomments
  end
end
