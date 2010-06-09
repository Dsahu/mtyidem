class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :photo

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
