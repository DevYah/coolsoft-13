class ArchiveNotification < IdeaNotification

  def self.send_notification(user_sender, users_receivers) 
    archive_notification = CommentNotification.new
    archive_notification.link = 'idea#show'
    archive_notification.user = user_sender
    archive_notification.idea = idea
    archive_notification.users << users_receivers
    archive_notification.save
  end

  def text
    if(!(User.find(self.user_id) == null || User.find(self.user_id).is_a? Admin))
      User.find(self.user_id).first_name + " archived his idea " + Idea.find(self.idea_id).title + "."
    else
      "The idea " + Idea.find(self.idea_id).title + " got archived."
  end

end