class CommentNotification < IdeaNotification

  def self.send_notification(user_sender, idea, users_receivers) 
    comment_notification = CommentNotification.create(user: user_sender, idea: idea, users: users_receivers)
    #link = 'idea#show', link_name = 'view idea'
  end

  def text
    User.find(self.user_id).first_name + " commented on your idea " + Idea.find(self.idea_id).title + "."
  end


end