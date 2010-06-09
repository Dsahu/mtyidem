class CreateStoresInGroups < ActiveRecord::Migration
  def self.up
    create_table :stores_in_groups do |t|
      t.integer :store_id
      t.integer :stroe_group_id

      t.timestamps
    end
  end

  def self.down
    drop_table :stores_in_groups
  end
end
