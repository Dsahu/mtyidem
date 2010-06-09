class CreateRuns < ActiveRecord::Migration
  def self.up
    create_table :runs do |t|
      t.string :name
      t.text :description
      t.date :eventday
      t.date :lastregisterday
      t.string :location
      t.integer :distance
      t.decimal :electronicservicequote
      t.boolean :showincarrusel
      t.boolean :showresults
      t.integer :fichastart
      t.integer :fichaend
      t.boolean :inscriptionopen
      t.integer :runtype_id
      t.string :flickrlink
      t.text :convocatoria
      t.text :descriptionadicional
      t.string :mainphoto
      t.string :diplomphoto
      t.string :sponsoringphoto
      t.string :mapphoto

      t.timestamps
    end
  end

  def self.down
    drop_table :runs
  end
end
