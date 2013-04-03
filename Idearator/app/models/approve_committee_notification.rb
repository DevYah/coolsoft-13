class ApproveCommitteeNotification < UserNotification

  def self.send_notification(user_sender, users_receivers) 
    approve_notification = ApproveCommitteeNotification.new
    approve_notification.link = '/'
    approve_notification.user = user_sender
    approve_notification.users << users_receivers
    approve_notification.save
  end

  def text
    return User.find(self.user_id).first_name + " has signed up as a committee member."
  end

end