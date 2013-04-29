class ApproveCommitteeNotification < UserNotification
  inherits_from :notification

  def self.send_notification(user_sender, users_receivers)
    approve_notification = ApproveCommitteeNotification.create(user: user_sender, users: users_receivers)
    user_ids = []
    users_receivers.each do |user|
      user_ids << user.id.to_s
    end
    NotificationsController::CoolsterPusher.new.push_notification user_ids, approve_notification
  end

  def text
   User.find(self.user_id).username + " has signed up as a committee member."
  end

end
