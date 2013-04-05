class ArchiveNotification < IdeaNotification

  def self.send_notification(user_sender, idea, users_receivers)
    archive_notification = ArchiveNotification.create(user: user_sender, idea: idea, users: users_receivers)
  end

  def text
    "The idea " + Idea.find(self.idea_id).title.to_s() + " got archived."
  end

  def link
    link_to "view idea", "idea#show"
  end

end