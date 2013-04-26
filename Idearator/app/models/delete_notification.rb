class DeleteNotification < ActiveRecord::Base
  inherits_from :notification

  belongs_to :idea
  belongs_to :user
  attr_accessible :type, :user, :idea, :idea_title, :users

  def self.send_notification(user_sender, idea, users_receivers)
    delete_notification = DeleteNotification.create(user: user_sender, idea: idea, idea_title: idea.title, users: users_receivers)
  end

  def text
    User.find(self.user_id).username + " deleted his idea " + self.idea_title + "."
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