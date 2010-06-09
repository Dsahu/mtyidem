class AddFieldsToUser < ActiveRecord::Migration
  def self.up
  	add_column :users, :firstname, :string
  	add_column :users, :lastname, :string
  	add_column :users, :street1, :string
  	add_column :users, :street2, :string
  	add_column :users, :zip, :string
  	add_column :users, :city, :string
  	add_column :users, :state_id, :integer
  	add_column :users, :country_id, :integer
  	add_column :users, :is_idem_admin, :boolean
  end

  def self.down
  end
end
