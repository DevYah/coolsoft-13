class EditUserNotifications < ActiveRecord::Migration
  def up
  	add_column :user_notifications, :link_name, :string, :default => "/"
  end

  def down
  end
end
