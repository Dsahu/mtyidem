class AddParticipantcountToRun < ActiveRecord::Migration
  def self.up
  	add_column :runs, :participantcount, :integer
  end

  def self.down
  end
end
