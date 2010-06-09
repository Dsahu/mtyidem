class AddSexToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :sex, :boolean, :default => true
  end

  def self.down
  end
end
