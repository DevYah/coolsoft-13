class NotificationsController < ApplicationController

	def view_notifications
		@idea_notifications = current_user.idea_notifications
		@user_notifications = current_user.user_notifications

		puts current_user.user_notifications
	end

end
