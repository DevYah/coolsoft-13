class EditNotification < IdeaNotification

  def self.send_notification(user_sender, idea, users_receivers)
    edit_notification = EditNotification.create(user: user_sender, idea: idea, users: users_receivers)
  end

end
