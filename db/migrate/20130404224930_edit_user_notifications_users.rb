class EditUserNotificationsUsers < ActiveRecord::Migration
  def up
  	add_column :user_notifications_users, :read, :boolean, :default => false
  end

  def down
  end
end
