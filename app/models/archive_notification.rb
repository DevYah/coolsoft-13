class ArchiveNotification < IdeaNotification

  def self.send_notification(user_sender, idea, users_receivers)
    archive_notification = ArchiveNotification.create(user: user_sender, idea: idea, users: users_receivers)
  end
  
end