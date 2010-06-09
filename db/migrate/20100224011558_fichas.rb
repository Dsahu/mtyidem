class Fichas < ActiveRecord::Migration
  def self.up
    add_column :inscriptions, :ficha, :integer
    add_column :runs, :last_ficha, :integer
  end

  def self.down
  end
end
