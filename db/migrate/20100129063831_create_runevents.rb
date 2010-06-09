class CreateRunevents < ActiveRecord::Migration
  def self.up
    create_table :runevents do |t|
      t.integer :run_id
      t.string :name
      t.text :description
      t.decimal :default_amount, :precision => 10, :scale => 2
      t.decimal :default_amount_extra, :precision => 10, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :runevents
  end
end
