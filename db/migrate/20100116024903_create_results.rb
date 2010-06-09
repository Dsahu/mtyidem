class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.integer :num
      t.string :cat
      t.integer :user_id
      t.string :firstname
      t.string :lastname
      t.integer :edad
      t.string :clubcustom
      t.integer :time_in_seconds
      t.integer :time_chip_in_seconds
      t.integer :rank_general
      t.integer :rank_rama
      t.integer :rank_cat
      t.integer :paso_in_seconds
      t.integer :run_id
      t.integer :part_1
      t.integer :part_2
      t.integer :part_3
      t.integer :part_4
      t.integer :part_5
      t.integer :part_6
      t.integer :part_7
      t.integer :part_8
      t.integer :part_9
      t.integer :part_10
      t.integer :pause_1
      t.integer :pause_2
      t.integer :pause_3
      t.integer :pause_4
      t.integer :pause_5
      t.integer :pause_6
      t.integer :pause_7
      t.integer :pause_8
      t.integer :pause_9

      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
