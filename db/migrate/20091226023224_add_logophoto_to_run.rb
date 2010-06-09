class AddLogophotoToRun < ActiveRecord::Migration
  def self.up
     add_column :runs, :logophoto, :string
  end

  def self.down
  end
end
