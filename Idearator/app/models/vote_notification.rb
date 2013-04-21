class VoteNotification < IdeaNotification

  def self.send_notification (user_sender, idea, users_receivers) 
    vote_notification = VoteNotification.create(user: user_sender, idea: idea, users: users_receivers)
  end

  def text
    "Your idea " + Idea.find(self.idea_id).title + " got a vote."  
  end

end
