class IdeaNotification < ActiveRecord::Base

  belongs_to :idea
  belongs_to :user
  has_many :idea_notifications_users, :dependent => :destroy
  has_many :users, :through => :idea_notifications_users
  attr_accessible :link, :type, :user, :idea, :users

  def self.send_notification(user_sender, idea, users_receivers)
  end

  def text 
  end

  def has_link?
    true
  end

  def read_by?(user)
    if IdeaNotificationsUser.find(:first, :conditions => { idea_notification_id: self.id, user_id: user.id }).read?
      true
    else
      false
    end
  end

  def read_for(user)
    notification = IdeaNotificationsUser.find(:first, :conditions => {idea_notification_id: self.id, user_id: user.id })
    notification.read = true
    notification.save
  end

end