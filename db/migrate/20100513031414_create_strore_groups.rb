class CreateStroreGroups < ActiveRecord::Migration
  def self.up
    create_table :store_groups do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :store_groups
  end
end
