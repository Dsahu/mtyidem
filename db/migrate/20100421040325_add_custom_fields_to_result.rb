class AddCustomFieldsToResult < ActiveRecord::Migration
  def self.up
    add_column :results, :custom_run_name, :string
    add_column :results, :custom_all_runners, :integer
    add_column :results, :custom_all_male, :integer
    add_column :results, :custom_all_female, :integer
    add_column :results, :custom_all_category, :integer
    add_column :results, :is_custom, :boolean, :default => false
  end

  def self.down
  end
end
