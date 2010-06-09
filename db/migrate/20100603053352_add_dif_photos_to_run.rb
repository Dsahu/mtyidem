class AddDifPhotosToRun < ActiveRecord::Migration
  def self.up
    add_column :runs, :shirtphoto, :string
    add_column :runs, :medaillephoto, :string
  end

  def self.down
  end
end
