class DisapproveIdeaNotification < IdeaNotification

  def self.send_notification(user_sender, users_receivers) 
    disapprove_notification = DisapproveIdeaNotification.new
    disapprove_notification.link = 'idea#show'
    disapprove_notification.user = user_sender
    disapprove_notification.idea = idea
    disapprove_notification.users << users_receivers
  end

  def text
    return "Your " + Idea.find(self.idea_id).title + " wasn't approved by the committee."
  end

end