class AddFieldsToRun < ActiveRecord::Migration
  def self.up
     add_column :runs, :showvideos, :boolean
     add_column :runs, :showphotos, :boolean
  end

  def self.down
  end
end
