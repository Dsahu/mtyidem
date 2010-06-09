class CreatePicturecomments < ActiveRecord::Migration
  def self.up
    create_table :picturecomments do |t|
      t.integer :picture_id
      t.integer :user_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :picturecomments
  end
end
