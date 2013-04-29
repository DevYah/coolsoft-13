class EnterIdeaNotification < CompetitionIdeaNotification
  inherits_from :notification

  def self.send_notification (user_sender, idea, competition, users_receivers)
    enter_idea_notification = EnterIdeaNotification.create(user: user_sender, idea: idea, competition: competition, users: users_receivers)
    user_ids = []
    users_receivers.each do |user|
      user_ids << user.id.to_s
    end
    NotificationsController::CoolsterPusher.new.push_notification user_ids, edit_idea_notification
  end

  def text
    "An idea was enrolled in your competition " + Competition.find(self.competition_id).title + "."
  end

end