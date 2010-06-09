class AddRunIdToUserResultAssignment < ActiveRecord::Migration
  def self.up
    add_column :user_result_assignments, :run_id, :integer
  end

  def self.down
  end
end
