class EditNotification < IdeaNotification

  def self.send_notification(user_sender, users_receivers) 
    edit_notification = CommentNotification.new
    edit_notification.link = 'idea#show'
    edit_notification.user = user_sender
    edit_notification.idea = idea
    edit_notification.users << users_receivers
    edit_notification.save
  end

  def text
    User.find(self.user_id).first_name + " edited his idea " + Idea.find(self.idea_id).title + "."
  end

end