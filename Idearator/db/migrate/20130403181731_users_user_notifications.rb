class UsersUserNotifications < ActiveRecord::Migration
  def change
    create_table :users_user_notifications, :id => false do |t|
    	t.references :user
    	t.references :user_notification
    end
  end
end
