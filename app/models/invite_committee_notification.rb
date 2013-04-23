class InviteCommitteeNotification < UserNotification

  def self.send_notification(user_sender, users_receivers)
    invite_notification = InviteCommitteeNotification.create(user: user_sender, users: users_receivers)
  end

end
