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

  # sets the read field to true for the specified notification and redirects to ideas#show.
  # Params:
  # +not_id+:: the parameter is an instance of +IdeaNotification+ passed through the view_notifications view.
  # Author: Amina Zoheir
  def redirect_idea
    notification = IdeaNotification.find(params[:notification])
    notification.set_read_for current_user
    respond_to do |format|
      format.js { render 'redirect', locals:{path: '/ideas/' + ((notification.idea.id).to_s)} }
      format.json { head :no_content }
    end
  end


  # sets the read field to true for the specified notification and redirects to users#expertise.
  # Params:
  # +not_id+:: the parameter is an instance of +UserNotification+ passed through the view_notifications view.
  # Author: Amina Zoheir
  def redirect_expertise
    notification = UserNotification.find(params[:notification])
    notification.set_read_for current_user
    respond_to do |format|
      redirect_to :controller => 'users', :action => 'send_expertise'
      format.json { head :no_content }
    end
  end


  # sets the read field to true for the specified notification and redirects to committees#review.
  # Params:
  # +not_id+:: the parameter is an instance of +UserNotification+ passed through the view_notifications view.
  # Author: Amina Zoheir
  def redirect_review
    notification = UserNotification.find(params[:notification])
    notification.set_read_for current_user
    respond_to do |format|
      format.js { render 'redirect', locals:{path: '/users/' + (notification.user.becomes(User).id).to_s} }
      format.json { head :no_content }
    end
  end

  def set_read
    notification = IdeaNotification.find(params[:notification])
    notification.set_read_for current_user
    respond_to do |format|
      format.js { render 'layouts/update_nav_bar' }
    end
  end

end
