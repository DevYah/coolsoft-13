class UserNotification < ActiveRecord::Base

  belongs_to :user
  has_many :user_notifications_users, :dependent => :destroy
  has_many :users, :through => :user_notifications_users
  attr_accessible :link, :type, :user, :users

  def self.send_notification(user_sender, idea, users_receivers)
  end

  def text
  end

  def read_by?(user)
    if UserNotificationsUser.find(:first, :conditions => {user_notification_id: self.id, user_id: user.id }).read
      true
    else
      false
    end
  end

  def read_for(user)
    notification = UserNotificationsUser.find(:first, :conditions => {user_notification_id: self.id, user_id: user.id })
    notification.read = true
    notification.save
  end

end
