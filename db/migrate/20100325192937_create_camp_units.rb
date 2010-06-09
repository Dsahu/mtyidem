class CreateCampUnits < ActiveRecord::Migration
  def self.up
    create_table :camp_units do |t|
      t.integer :campaign_id
      t.string :name
      t.text :description
      t.string :path
      t.integer :image_where

      t.timestamps
    end
  end

  def self.down
    drop_table :camp_units
  end
end
