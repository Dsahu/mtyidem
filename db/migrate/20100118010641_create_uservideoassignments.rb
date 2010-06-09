class CreateUservideoassignments < ActiveRecord::Migration
  def self.up
    create_table :uservideoassignments do |t|
      t.integer :video_id
      t.integer :user_id
      t.integer :tagged_by_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :uservideoassignments
  end
end
