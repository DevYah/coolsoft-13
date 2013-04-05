class NotificationsController < ApplicationController
  before_filter :authenticate_user!, :only => [:view_notifications]

  def view_notifications
    @idea_notifications = current_user.idea_notifications
    @user_notifications = current_user.user_notifications
    @not = @idea_notifications + @user_notifications
    @not2 = @not.sort_by &:created_at
    @notifications = @not2.reverse
  end

  def view_all_notifications
    @idea_notifications = current_user.idea_notifications
    @user_notifications = current_user.user_notifications
    @not = @idea_notifications + @user_notifications
    @not2 = @not.sort_by &:created_at
    @notifications = @not2.reverse
  end

end
