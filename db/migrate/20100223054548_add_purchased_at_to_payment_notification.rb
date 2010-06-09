class AddPurchasedAtToPaymentNotification < ActiveRecord::Migration
  def self.up
    add_column :payment_notifications, :purchased_at, :datetime
  end

  def self.down
  end
end
