class NotificationsController < ApplicationController
  before_filter :authenticate_user!, :only => [:view_all_notifications]

  def view_new_notifications
    idea_notifications = IdeaNotification.joins(:idea_notifications_users).where('idea_notifications_users.user_id = ? and created_at > ?', current_user, Time.at(params[:after].to_i + 1))
    user_notifications = UserNotification.joins(:user_notifications_users).where('user_notifications_users.user_id = ? and created_at > ?', current_user, Time.at(params[:after].to_i + 1))
    notifications = idea_notifications + user_notifications
    sorted_notifications = notifications.sort_by &:created_at
    @new_notifications = sorted_notifications.reverse
  end

  # gets all current users notifications.
  # Params: none.
  # Author: Amina Zoheir
  def view_all_notifications
  end

end
