class DisapproveIdeaNotification < IdeaNotification

  def self.send_notification(user_sender, idea, users_receivers)
    disapprove_notification = DisapproveIdeaNotification.create(user: user_sender, idea: idea, users: users_receivers)
  end
end