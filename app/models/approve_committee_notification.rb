class ApproveCommitteeNotification < UserNotification

  def self.send_notification(user_sender, users_receivers)
    approve_notification = ApproveCommitteeNotification.create(user: user_sender, users: users_receivers)
  end

end
