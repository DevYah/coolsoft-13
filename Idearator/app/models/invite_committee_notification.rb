class InviteCommitteeNotification < UserNotification

  def self.send_notification(user_sender, users_receivers) 
    invite_notification = InviteCommitteeNotification.create(user: user_sender, users: users_receivers)
    #link = 'users#expertise', link_name = 'choose area of expertise'
  end

  def text
    return "You have been invited to become a committee member."
  end

end