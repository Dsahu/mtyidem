class CustomFieldsForInscriptions < ActiveRecord::Migration
  def self.up
    add_column :inscriptions, :firstname, :string
    add_column :inscriptions, :lastname, :string
    add_column :inscriptions, :age, :integer
    add_column :inscriptions, :email, :string
    
  end

  def self.down
  end
end
