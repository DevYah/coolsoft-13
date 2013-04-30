class CompetitionIdeaNotification < ActiveRecord::Base
  inherits_from :notification

  belongs_to :idea
  belongs_to :user
  belongs_to :competition
  attr_accessible :type, :user, :competition, :idea, :users

  def self.send_notification(user_sender, idea, competition, users_receivers)
  end

  def text
  end

  def read_by?(user)
    if NotificationsUser.find(:first, :conditions => {notification_id: self.id, user_id: user.id }).read
      true
    else
      false
    end
  end

  def set_read_for(user)
    notification = NotificationsUser.find(:first, :conditions => {notification_id: self.id, user_id: user.id})

    notification.read = true
    notification.save
  end

end