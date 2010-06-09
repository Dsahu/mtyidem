class AddOtherCustomFieldsToResult < ActiveRecord::Migration
  def self.up
    add_column :results, :custom_run_distance, :decimal, :scale => 2, :precision => 5, :default => 0.0
    add_column :results, :custom_run_logo, :string
    
  end

  def self.down
  end
end
