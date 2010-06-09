class CreateDiplomaSchemas < ActiveRecord::Migration
  def self.up
    create_table :diploma_schemas do |t|
      t.integer :run_id
      t.integer :size_x
      t.integer :size_y
      t.string :photopath

      t.timestamps
    end
  end

  def self.down
    drop_table :diploma_schemas
  end
end
