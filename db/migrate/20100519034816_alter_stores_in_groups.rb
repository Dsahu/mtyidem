class AlterStoresInGroups < ActiveRecord::Migration
  def self.up
    rename_column :stores_in_groups, :stroe_group_id, :store_group_id
  end

  def self.down
  end
end
