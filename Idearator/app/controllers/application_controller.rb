class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :only => [:load_notifications, :update_nav_bar]
  before_filter :load_notifications
  protect_from_forgery

  # gets first 10 current users notifications and the number of unread notificaations.
  # Params: none.
  # Author: Amina Zoheir
  def load_notifications
    if user_signed_in?
      unread_notifications = NotificationsUser.find(:all, :conditions => {user_id: current_user.id, read: false }).length
      notifications = current_user.notifications
      sorted_notifications = notifications.sort_by &:created_at
      @all_notifications = sorted_notifications.reverse
      @notifications = sorted_notifications.reverse.first(7)
      @count = unread_notifications
    end
  end

  # renders update_nav_bar.
  # Params: none.
  # Author: Amina Zoheir
  def update_nav_bar
    respond_to do |format|
      format.js { render 'layouts/update_nav_bar' }
    end
  end
end
