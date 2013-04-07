class NotificationsController < ApplicationController
  before_filter :authenticate_user!, :only => [:view_notifications]

  def view_all_notifications
    if(user_signed_in?)
      idea_notifications = current_user.idea_notifications
      user_notifications = current_user.user_notifications
      not1 = idea_notifications + user_notifications
      not2 = not1.sort_by &:created_at
      @all_notifications = not2.reverse
    end
  end

end
