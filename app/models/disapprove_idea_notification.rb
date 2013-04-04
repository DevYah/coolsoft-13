class DisapproveIdeaNotification < IdeaNotification

  def self.send_notification(user_sender, idea, users_receivers) 
    disapprove_notification = DisapproveIdeaNotification.new
    disapprove_notification.link = 'idea#show'
    disapprove_notification.user = user_sender
    disapprove_notification.idea = idea
    disapprove_notification.users << users_receivers
    disapprove_notification.save
  end

  def text
    return "Your " + Idea.find(self.idea_id).title.to_s() + " wasn't approved by the committee."
  end

end