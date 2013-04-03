class CommentNotification < IdeaNotification

  def self.send_notification(user_sender, users_receivers) 
    comment_notification = CommentNotification.new
    comment_notification.link = 'idea#show'
    comment_notification.user = user_sender
    comment_notification.idea = idea
    comment_notification.users << users_receivers
    comment_notification.save
  end

  def text
    User.find(self.user_id).first_name + " commented on your idea " + Idea.find(self.idea_id).title + "."
  end


end