class CreateWallevents < ActiveRecord::Migration
  def self.up
    create_table :wallevents do |t|
      t.integer :type
      t.string :name
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :wallevents
  end
end
