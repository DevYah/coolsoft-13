class InviteCommitteeNotification < UserNotification

  def self.send_notification(user_sender, users_receivers) 
    invite_notification = InviteCommitteeNotification.new
    invite_notification.link = '/'
    invite_notification.user = user_sender
    invite_notification.users << users_receivers
    invite_notification.save
  end

  def text
    return "You have been invited to become a committee member."
  end

end