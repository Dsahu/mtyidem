class CreateGrandprixes < ActiveRecord::Migration
  def self.up
    create_table :grandprixes do |t|
      t.string :name
      t.string :name1
      t.string :name2
      t.string :name3
      t.string :name4
      t.string :name5
      t.string :name6
      t.string :name7
      t.string :name8
      t.string :name9
      t.string :name10
      t.string :name11
      t.string :name12
      t.string :name13
      t.string :name14
      t.string :name15
      t.string :name16
      t.string :name17
      t.string :name18
      t.string :name19
      t.string :name20
      t.string :name21
      t.string :name22
      t.string :name23
      t.string :name24

      t.timestamps
    end
  end

  def self.down
    drop_table :grandprixes
  end
end
