class DeleteNotification < IdeaNotification

  def self.send_notification(user_sender, idea, users_receivers)
    delete_notification = DeleteNotification.new
    delete_notification.link = '/'
    delete_notification.user = user_sender
    delete_notification.idea = idea
    delete_notification.users << users_receivers
    delete_notification.save
  end

  def text
    User.find(self.user_id).first_name + " deleted his idea " + Idea.find(self.idea_id).title + "."
  end

end