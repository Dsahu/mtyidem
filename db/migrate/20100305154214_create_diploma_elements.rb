class CreateDiplomaElements < ActiveRecord::Migration
  def self.up
    create_table :diploma_elements do |t|
      t.integer :font_size
      t.string :font_weight
      t.string :font_family
      t.integer :pos_x
      t.integer :pos_y
      t.boolean :is_italic
      t.string :column_name
      t.integer :diploma_schema_id

      t.timestamps
    end
  end

  def self.down
    drop_table :diploma_elements
  end
end
