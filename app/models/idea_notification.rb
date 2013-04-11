class IdeaNotification < ActiveRecord::Base

  belongs_to :idea
  belongs_to :user
  has_and_belongs_to_many :users
  attr_accessible :link, :type, :user, :idea, :users
  has_many :idea_notifications_users
  has_many :users, :through => :idea_notifications_users
  attr_accessible :link, :type, :user, :idea, :users

  def self.send_notification(user_sender, idea, users_receivers)
  end

end
