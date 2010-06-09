class AlterWallEvent < ActiveRecord::Migration
  def self.up
    change_column :wallevents, :name, :string, :limit => 512
  end

  def self.down
  end
end
