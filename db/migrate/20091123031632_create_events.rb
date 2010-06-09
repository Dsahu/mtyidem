class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.text :description
      t.integer :organizator_id
      t.boolean :idemserial
      t.string :phone
      t.string :location
      t.boolean :visible
      t.date :when

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
