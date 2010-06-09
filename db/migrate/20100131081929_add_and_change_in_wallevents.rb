class AddAndChangeInWallevents < ActiveRecord::Migration
  def self.up
    rename_column :wallevents, :type, :we_type
    add_column :wallevents, :otheruser_id, :integer
    add_column :wallevents, :run_id, :integer
    add_column :wallevents, :picture_id, :integer
    add_column :wallevents, :video_id, :integer
    add_column :wallevents, :group_id, :integer
  end

  def self.down
  end
end
