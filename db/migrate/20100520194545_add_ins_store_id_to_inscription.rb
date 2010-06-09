class AddInsStoreIdToInscription < ActiveRecord::Migration
  def self.up
    add_column :inscriptions, :ins_store_id, :integer
  end

  def self.down
  end
end
