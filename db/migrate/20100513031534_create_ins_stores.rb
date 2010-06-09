class CreateInsStores < ActiveRecord::Migration
  def self.up
    create_table :ins_stores do |t|
      t.string :name
      t.text :description
      t.integer :store_id
      t.integer :run_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ins_stores
  end
end
