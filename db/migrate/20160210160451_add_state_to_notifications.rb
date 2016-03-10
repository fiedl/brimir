class AddStateToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :state, :integer
  end
end
