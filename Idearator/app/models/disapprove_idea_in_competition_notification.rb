class DisapproveIdeaInCompetitionNotification < CompetitionIdeaNotification
  inherits_from :notification

  def self.send_notification (user_sender, idea, competition, users_receivers)
    disapprove_idea_in_competition_notification = DisapproveIdeaInCompetitionNotification.create(user: user_sender, idea: idea, competition: competition, users: users_receivers)
    NotificationsController::CoolsterPusher.new.push_notification users_receivers, disapprove_idea_in_competition_notification
  end

  def text
    "Your idea " + Idea.find(self.idea_id).title + " wasn't approved in the competition " + Competition.find(self.competition_id).title + "."
  end

end