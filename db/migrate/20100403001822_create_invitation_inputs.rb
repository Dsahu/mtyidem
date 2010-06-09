class CreateInvitationInputs < ActiveRecord::Migration
  def self.up
    create_table :invitation_inputs do |t|
      t.integer :user_id
      t.string :input, :limit => 512

      t.timestamps
    end
  end

  def self.down
    drop_table :invitation_inputs
  end
end
