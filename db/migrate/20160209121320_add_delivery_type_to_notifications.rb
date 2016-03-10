class AddDeliveryTypeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :delivery_type, :integer
  end
end
