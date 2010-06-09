class AddSizesToPicture < ActiveRecord::Migration
  def self.up
    add_column :pictures, :width, :integer
    add_column :pictures, :height, :integer
  end

  def self.down
  end
end
