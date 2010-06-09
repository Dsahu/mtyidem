class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.string :name
      t.text :description
      t.integer :upload_by_user_id
      t.string :path
      t.integer :run_id
      t.boolean :visible
      t.integer :counter

      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
