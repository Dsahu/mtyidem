class AddColorToInscription < ActiveRecord::Migration
  def self.up
    add_column :inscriptions, :color, :string
    add_column :inscriptions, :city, :string
  end

  def self.down
  end
end
