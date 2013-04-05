class DeleteNotification < IdeaNotification

  def self.send_notification(user_sender, idea, users_receivers)
    delete_notification = DeleteNotification.create(user: user_sender, idea: idea, users: users_receivers)
    #link = none
  end

  def text
    User.find(self.user_id).first_name + " deleted his idea " + Idea.find(self.idea_id).title + "."
  end

end