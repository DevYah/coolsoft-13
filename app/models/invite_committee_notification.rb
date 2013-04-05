class InviteCommitteeNotification < UserNotification

  def self.send_notification(user_sender, users_receivers) 
    invite_notification = InviteCommitteeNotification.create(user: user_sender, users: users_receivers)
  end

  def text
    return "You have been invited to become a committee member."
  end

  def link
    link_to "choose area of expertise", "users#expertise"
  end

end