class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :only => [:load_notifications, :update_nav_bar]
  before_filter :load_notifications
  protect_from_forgery

  # gets first 10 current users notifications and the number of unread notificaations.
  # Params: none.
  # Author: Amina Zoheir
  def load_notifications
    if user_signed_in?
      @all_notifications = current_user.get_notifications
      @notifications = @all_notifications.first(7)
      @count = current_user.unread_notifications_count
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
