class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.string :name
      t.text :description
      t.integer :mode
      t.string :title
      t.string :subtitle
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :campaigns
  end
end
