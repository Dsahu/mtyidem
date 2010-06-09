class CreateFriendRequests < ActiveRecord::Migration
  def self.up
    create_table :friend_requests do |t|
      t.integer :inviter_id
      t.integer :other_id
      t.integer :status

      t.timestamps
    end
  end

  def self.down
    drop_table :friend_requests
  end
end
