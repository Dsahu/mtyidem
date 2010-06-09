class AddInsDate < ActiveRecord::Migration
  def self.up
  	add_column :inscriptions, :ins_date, :date
  end

  def self.down
  end
end
