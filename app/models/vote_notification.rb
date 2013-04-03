class VoteNotification < IdeaNotification

  def self.send_notification (user_sender, users_receivers) 
    vote_notification = VoteNotification.new
    vote_notification.link = 'idea#show'
    vote_notification.user = user_sender
    vote_notification.idea = idea
    vote_notification.users << users_receivers
    vote_notification.save
  end

  def text
  	"Your idea " + Idea.find(self.idea_id).title + " got a vote."
  end

end
