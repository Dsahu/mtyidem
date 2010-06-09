class CreateInscriptions < ActiveRecord::Migration
  def self.up
    create_table :inscriptions do |t|
      t.integer :user_id
      t.integer :paidfrom_id
      t.decimal :amount
      t.datetime :signed_at
      t.datetime :completed_at
      t.integer :run_id
      t.text :description
      t.integer :runevent_id
      t.string :status
      t.integer :statuscode
      t.integer :dresssize
      t.integer :age_at_inscription

      t.timestamps
    end
  end

  def self.down
    drop_table :inscriptions
  end
end
