class UserNotificationsUser < ActiveRecord::Base
  belongs_to :user_notification
  belongs_to :user
end
