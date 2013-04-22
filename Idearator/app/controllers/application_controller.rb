class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :only => [:load_notifications, :update_nav_bar]
  before_filter :load_notifications
  protect_from_forgery

  # redirect committee members to controller user action expertise for their first sign in
  # Params:
  # none
  # Author: Mohamed Sameh
  def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1
      if current_user.is_a? Committee
        '/users/expertise'
      else
        '/'
      end
    else
      '/'
    end
  end

  # gets first 10 current users notifications and the number of unread notificaations.
  # Params: none.
  # Author: Amina Zoheir
  def load_notifications
    if user_signed_in?
      idea_notifications = current_user.idea_notifications
      user_notifications = current_user.user_notifications
      unread_ideas = IdeaNotificationsUser.find(:all, :conditions => {user_id: current_user.id, read: false }).length
      unread_users = UserNotificationsUser.find(:all, :conditions => {user_id: current_user.id, read: false }).length
      not1 = idea_notifications + user_notifications
      not2 = not1.sort_by &:created_at
      @notifications = not2.reverse.first(10)
      @count = unread_users + unread_ideas
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
