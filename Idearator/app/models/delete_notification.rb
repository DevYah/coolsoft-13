class DeleteNotification < IdeaNotification

  def self.send_notification(user_sender, idea, users_receivers)
    delete_notification = DeleteNotification.create(user: user_sender, idea: idea, users: users_receivers)
  end

end
