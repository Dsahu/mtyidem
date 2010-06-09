class CreateConvocatoriaunits < ActiveRecord::Migration
  def self.up
    create_table :convocatoriaunits do |t|
      t.string :name
      t.text :description
      t.integer :ordernum
      t.integer :run_id

      t.timestamps
    end
  end

  def self.down
    drop_table :convocatoriaunits
  end
end
