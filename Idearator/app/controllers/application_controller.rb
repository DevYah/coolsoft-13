class ApplicationController < ActionController::Base
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

  def load_notifications
    if user_signed_in?
      idea_notifications = current_user.idea_notifications
      user_notifications = current_user.user_notifications
      not1 = idea_notifications + user_notifications
      not2 = not1.sort_by &:created_at
      @notifications = not2.reverse.first(10)
    end
  end

end
