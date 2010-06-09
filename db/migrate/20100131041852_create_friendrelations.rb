class CreateFriendrelations < ActiveRecord::Migration
  def self.up
    create_table :friendrelations do |t|
      t.integer :inviter_id
      t.integer :other_id

      t.timestamps
    end
  end

  def self.down
    drop_table :friendrelations
  end
end
