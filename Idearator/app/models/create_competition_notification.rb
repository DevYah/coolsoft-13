class CreateCompetitionNotification < CompetitionNotification
  inherits_from :notification

  def self.send_notification (user_sender, competition, users_receivers)
    create_competition_notification = CreateCompetitionNotification.create(user: user_sender, competition: competition, users: users_receivers)
    user_ids = []
    users_receivers.each do |user|
      user_ids << user.id.to_s
    end
    NotificationsController::CoolsterPusher.new.push_notification user_ids, create_competition_notification
  end

  def text
    competition = Competition.find(self.competition_id)
    competition.investor.username + " created a new competition " + competition.title + "."
  end

end