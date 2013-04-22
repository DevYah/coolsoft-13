class NotificationsController < ApplicationController
  before_filter :authenticate_user!, :only => [:view_all_notifications]

  # gets all current users notifications.
  # Params: none.
  # Author: Amina Zoheir
  def view_all_notifications
    if user_signed_in?
      idea_notifications = current_user.idea_notifications
      user_notifications = current_user.user_notifications
      not1 = idea_notifications + user_notifications
      not2 = not1.sort_by &:created_at
      @all_notifications = not2.reverse
    end
  end

  # sets the read field to true for the specified notification and redirects to ideas#show.
  # Params:
  # +not_id+:: the parameter is an instance of +IdeaNotification+ passed through the view_notifications view.
  # Author: Amina Zoheir
  def redirect_idea
    idea_not = IdeaNotificationsUser.find(:first, :conditions => {idea_notification_id: params[:not_id], user_id: current_user.id })
    idea_not.read = true
    idea_not.save
    respond_to do |format|
      format.html { redirect_to IdeaNotification.find(params[:not_id]).idea }
      format.json { head :no_content }
    end
  end


  # sets the read field to true for the specified notification and redirects to users#expertise.
  # Params:
  # +not_id+:: the parameter is an instance of +UserNotification+ passed through the view_notifications view.
  # Author: Amina Zoheir
  def redirect_expertise
    user_not = UserNotificationsUser.find(:first, :conditions => {user_notification_id: params[:not_id], user_id: current_user.id })
    user_not.read = true
    user_not.save
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
    user_not = UserNotificationsUser.find(:first, :conditions => {user_notification_id: params[:not_id], user_id: current_user.id })
    user_not.read = true
    user_not.save
    respond_to do |format|
      format.html { redirect_to UserNotification.find(params[:not_id]).user.becomes(User) }
      format.json { head :no_content }
    end
  end

end
