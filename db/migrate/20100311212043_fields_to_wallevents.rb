class FieldsToWallevents < ActiveRecord::Migration
  def self.up
    add_column :wallevents, :userpictureassignment_id, :integer
    add_column :wallevents, :uservideoassignment_id, :integer
  end

  def self.down
  end
end
