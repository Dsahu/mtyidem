class CreateUserpictureassignments < ActiveRecord::Migration
  def self.up
    create_table :userpictureassignments do |t|
      t.integer :picture_id
      t.integer :user_id
      t.integer :tagged_by_user_id
      t.integer :cor_x
      t.integer :cor_y

      t.timestamps
    end
  end

  def self.down
    drop_table :userpictureassignments
  end
end
