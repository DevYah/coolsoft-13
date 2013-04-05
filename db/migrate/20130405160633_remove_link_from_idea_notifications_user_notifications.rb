class RemoveLinkFromIdeaNotificationsUserNotifications < ActiveRecord::Migration
  def up
  	remove_column :user_notifications, :link_name
  	remove_column :user_notifications, :link
  	remove_column :idea_notifications, :link_name
  	remove_column :idea_notifications, :link
  end

  def down
  	add_column :user_notifications, :link_name
  	add_column :user_notifications, :link
  	add_column :idea_notifications, :link_name
  	add_column :idea_notifications, :link
  end
end
