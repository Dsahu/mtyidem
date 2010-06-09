class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.integer :wallevent_id
      t.integer :user_id
      t.integer :by_user_id
      t.text :description
      t.integer :result_id

      t.timestamps
    end
  end

  def self.down
    drop_table :responses
  end
end
