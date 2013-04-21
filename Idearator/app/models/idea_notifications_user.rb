class IdeaNotificationsUser < ActiveRecord::Base
  belongs_to :idea_notification
  belongs_to :user
end