class CreateCampPics < ActiveRecord::Migration
  def self.up
    create_table :camp_pics do |t|
      t.string :path
      t.string :name
      t.integer :campaign_id

      t.timestamps
    end
  end

  def self.down
    drop_table :camp_pics
  end
end
