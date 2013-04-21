class DeleteNotification < IdeaNotification

  def self.send_notification(user_sender, idea, users_receivers)
    delete_notification = DeleteNotification.create(user: user_sender, idea: idea, users: users_receivers)
  end

  def text
    User.find(self.user_id).username + " deleted his idea " + Idea.find(self.idea_id).title + "." 
  end

  def has_link?
    false
  end

end