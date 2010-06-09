class AddBdayProfilepicToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :bday, :date
    add_column :users, :profilepic, :string
    add_column :users, :default_dress_size, :integer
  end

  def self.down
  end
end
