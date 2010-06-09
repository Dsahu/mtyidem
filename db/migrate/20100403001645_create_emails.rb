class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.string :name
      t.string :description
      t.integer :from_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
