class AddOtherPicsToRun < ActiveRecord::Migration
  def self.up
    add_column :runs, :trofeophoto, :string
    add_column :runs, :rifaphoto, :string
    add_column :runs, :altimetrophoto, :string
  end

  def self.down
  end
end
