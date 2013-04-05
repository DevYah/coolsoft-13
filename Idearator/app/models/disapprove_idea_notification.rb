class DisapproveIdeaNotification < IdeaNotification

  def self.send_notification(user_sender, idea, users_receivers) 
    disapprove_notification = DisapproveIdeaNotification.create(user: user_sender, idea: idea, users: users_receivers)
    #link = 'idea#show', link_name = 'view idea'
  end

  def text
    return "Your " + Idea.find(self.idea_id).title + " wasn't approved by the committee."
  end

end