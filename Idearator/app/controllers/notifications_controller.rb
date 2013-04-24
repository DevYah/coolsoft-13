class NotificationsController < ApplicationController
  before_filter :authenticate_user!, :only => [:view_all_notifications]

  def view_new_notifications
    @new_notifications = current_user.new_notifications(params[:after])
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
    notification = Notification.find(params[:notification])
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
    notification = Notification.find(params[:notification])
    notification.set_read_for current_user
    respond_to do |format|
      format.js { render 'redirect_expertise' }
      format.json { head :no_content }
    end
  end

  # sets the read field to true for the specified notification and redirects to committees#review.
  # Params:
  # +not_id+:: the parameter is an instance of +UserNotification+ passed through the view_notifications view.
  # Author: Amina Zoheir
  def redirect_review
    notification = Notification.find(params[:notification])
    notification.set_read_for current_user
    respond_to do |format|
      format.js { render 'redirect', locals:{path: '/users/' + (notification.user.becomes(User).id).to_s} }
      format.json { head :no_content }
    end
  end

  def set_read
    notification = Notification.find(params[:notification])
    notification.set_read_for current_user
    respond_to do |format|
      format.js { render 'layouts/update_nav_bar' }
    end
  end

end
