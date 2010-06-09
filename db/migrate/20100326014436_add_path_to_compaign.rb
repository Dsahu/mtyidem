class AddPathToCompaign < ActiveRecord::Migration
  def self.up
    add_column :campaigns, :path, :string
  end

  def self.down
  end
end
