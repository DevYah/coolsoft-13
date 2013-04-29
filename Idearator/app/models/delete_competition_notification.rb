class DeleteCompetitionNotification < ActiveRecord::Base
  inherits_from :notification

  belongs_to :user
  belongs_to :competition
  attr_accessible :user, :idea, :competition_title, :users

  def self.send_notification(user_sender,competition, users_receivers)
    delete_competition_notification = DeleteCompetitionNotification.create(user: user_sender,competition: competition, competition_title: competition.title, users: users_receivers)
    user_ids = []
    users_receivers.each do |user|
      user_ids << user.id.to_s
    end
    NotificationsController::CoolsterPusher.new.push_notification user_ids, delete_competition_notification
  end

  def text
    User.find(self.user_id).username + " deleted his competition " + self.competition_title + "."
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
