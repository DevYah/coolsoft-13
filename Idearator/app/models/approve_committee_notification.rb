class ApproveCommitteeNotification < UserNotification

  def self.send_notification(user_sender, users_receivers) 
    approve_notification = ApproveCommitteeNotification.create(user: user_sender, users: users_receivers)
  end

  def text
    return User.find(self.user_id).first_name + " has signed up as a committee member."
  end

  def link
    link_to "review", "committees#review_ideas"
  end

end