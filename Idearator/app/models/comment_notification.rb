class CommentNotification < IdeaNotification

  def self.send_notification(user_sender, idea, users_receivers)
    comment_notification = CommentNotification.create(user: user_sender, idea: idea, users: users_receivers)
  end

end
