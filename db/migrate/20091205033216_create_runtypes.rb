class CreateRuntypes < ActiveRecord::Migration
  def self.up
    create_table :runtypes do |t|
      t.string :name
      t.text :description
      t.integer :parts
      t.string :part_name_1
      t.string :part_name_2
      t.string :part_name_3
      t.string :part_name_4
      t.string :part_name_5
      t.string :part_name_6
      t.string :part_name_7
      t.string :part_name_8
      t.string :part_name_9
      t.string :part_name_10

      t.timestamps
    end
  end

  def self.down
    drop_table :runtypes
  end
end
