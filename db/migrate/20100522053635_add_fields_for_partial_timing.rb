class AddFieldsForPartialTiming < ActiveRecord::Migration
  def self.up
    # RUN
    add_column :runs, :partial_name_time1, :string, :default => ""
    add_column :runs, :partial_name_time2, :string, :default => ""

    # RESULT
    add_column :results, :time_chip_in_seconds1, :integer, :default => 0
    add_column :results, :time_chip_in_seconds2, :integer, :default => 0
    add_column :results, :paso_in_seconds1, :integer, :default => 0
    add_column :results, :paso_in_seconds2, :integer, :default => 0
  end

  def self.down
  end
end
