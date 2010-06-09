class AddPhoneAndCategoryIdToInscription < ActiveRecord::Migration
  def self.up
    add_column :inscriptions, :phone, :string
    add_column :inscriptions, :runner_category_id, :integer
  end

  def self.down
  end
end
