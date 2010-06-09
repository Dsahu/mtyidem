class AddCustomDateToResult < ActiveRecord::Migration
  def self.up
    add_column :results, :custom_date, :date
  end

  def self.down
  end
end
