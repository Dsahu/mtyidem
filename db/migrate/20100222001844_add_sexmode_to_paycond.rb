class AddSexmodeToPaycond < ActiveRecord::Migration
  def self.up
    add_column :payconds, :sexmode, :integer, :default => 1
  end

  def self.down
  end
end
