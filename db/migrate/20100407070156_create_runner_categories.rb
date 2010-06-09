class CreateRunnerCategories < ActiveRecord::Migration
  def self.up
    create_table :runner_categories do |t|
      t.string :name
      t.integer :run_id
      t.integer :from_age
      t.integer :to_age
      t.integer :sex_mode

      t.timestamps
    end
  end

  def self.down
    drop_table :runner_categories
  end
end
