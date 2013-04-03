class ArchiveNotification < IdeaNotification

  def self.send_notification(user_sender, idea, users_receivers)
    archive_notification = ArchiveNotification.new
    archive_notification.link = 'idea#show'
    archive_notification.user = user_sender
    archive_notification.idea = idea
    archive_notification.users << users_receivers
    archive_notification.save
  end

  def text
    "The idea " + Idea.find(self.idea_id).title + " got archived."
  end

end