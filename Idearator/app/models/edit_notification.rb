class EditNotification < IdeaNotification

  def self.send_notification(user_sender, idea, users_receivers) 
    edit_notification = EditNotification.create(user: user_sender, idea: idea, users: users_receivers)  end

  def text
    User.find(self.user_id).first_name.to_s() + " edited his idea " + Idea.find(self.idea_id).title.to_s() + "."
  end

  def link
    link_to "view idea", "idea#show"
  end

end