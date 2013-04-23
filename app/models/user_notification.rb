class UserNotification < ActiveRecord::Base

  belongs_to :user
  has_many :user_notifications_users, :dependent => :destroy
  has_many :users, :through => :user_notifications_users
  attr_accessible :link, :type, :user, :users

  def self.send_notification(user_sender, idea, users_receivers)
  end

end
