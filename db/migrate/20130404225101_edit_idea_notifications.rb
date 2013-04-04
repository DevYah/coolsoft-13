class EditIdeaNotifications < ActiveRecord::Migration
  def up
  	add_column :idea_notifications, :link_name, :string, :default => "/"
  end

  def down
  end
end
