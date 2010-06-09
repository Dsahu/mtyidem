class AddRunIdToEvent < ActiveRecord::Migration
  def self.up
     add_column :events, :run_id, :integer
  end

  def self.down
  end
end
