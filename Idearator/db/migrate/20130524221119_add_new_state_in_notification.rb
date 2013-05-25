class AddNewStateInNotification < ActiveRecord::Migration
  def change
    add_column :notifications_users, :new_notification, :boolean, :default => true
  end
end
