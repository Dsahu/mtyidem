class AddColorToRunnerCategory < ActiveRecord::Migration
  def self.up
    add_column :runner_categories, :color, :string
  end

  def self.down
  end
end
