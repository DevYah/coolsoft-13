class UserNotification < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :users
  has_many :user_notifications_users
  has_many :users, :through => :user_notifications_users
  attr_accessible :link, :type, :user, :users

  def self.send_notification(user_sender, idea, users_receivers)
  end

end
