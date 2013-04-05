class IdeaNotification < ActiveRecord::Base

  belongs_to :idea
  belongs_to :user
  has_and_belongs_to_many :users
  attr_accessible :link, :type, :user, :idea, :users 


  def self.send_notification(user_sender, idea, users_receivers)
  end

  def text
  end

  def link
  end

end
