class PathFieldsToPicturesAndProfilepic < ActiveRecord::Migration
  def self.up
    add_column :pictures, :s_path, :string
    add_column :pictures, :m_path, :string
    add_column :pictures, :l_path, :string
    
    add_column :users, :s_profilepic, :string
  end

  def self.down
  end
end
