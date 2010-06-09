class AddClubsToResultAndInscription < ActiveRecord::Migration
  def self.up
    add_column :results, :club, :string
    add_column :inscriptions, :club, :string
    add_column :users, :club, :string
  end

  def self.down
  end
end
