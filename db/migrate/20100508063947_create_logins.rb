class CreateLogins < ActiveRecord::Migration
  def self.up
    create_table :logins do |t|
      t.string :email
      t.string :password
      t.boolean :failed, :default => false
      t.string :ipaddr
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :logins
  end
end
