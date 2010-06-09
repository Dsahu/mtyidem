class CreateOrganizators < ActiveRecord::Migration
  def self.up
    create_table :organizators do |t|
      t.string :name
      t.text :description
      t.text :address
      t.string :phone
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :organizators
  end
end
