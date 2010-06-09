class CreatePayconds < ActiveRecord::Migration
  def self.up
    create_table :payconds do |t|
      t.integer :runevent_id
      t.decimal :amount, :precision => 10, :scale => 2
      t.decimal :amount_extra, :precision => 10, :scale => 2
      t.integer :from_age, :default => 0
      t.integer :to_age, :default => 99

      t.timestamps
    end
  end

  def self.down
    drop_table :payconds
  end
end
