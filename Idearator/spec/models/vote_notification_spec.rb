require 'spec_helper'

describe VoteNotification do
  user1 = User.create(email: 'amina@gmail.com', password: '123123123', username: 'amina')
  user2 = User.create(email: 'marwa@gmail.com', password: '123123123', username: 'marwa')
  idea = Idea.create(title: 'Idea', description: 'Idea Description', problem_solved: 'Problem')
  idea.user = user1
  notification = VoteNotification.create(user: user2, idea: idea, users: [user1])

  it 'adds vote notification to idea_notifications table'do
    VoteNotification.send_notification(user1, idea, [user2])
    expect(IdeaNotification.last.type).to eq('VoteNotification')
    expect(IdeaNotification.last.idea_id).to eq(idea.id)
    expect(IdeaNotification.last.user_id).to eq(user1.id)
    expect(IdeaNotification.last.users).to include(user2)
  end

  it 'returns the notifications text'do
    expect(notification.text).to eq('Your idea Idea got a vote.')
  end

  it 'returns the value of the read variable'do
    notification_user= IdeaNotificationsUser.find(:first, :conditions => {idea_notification_id: notification.id, user_id: user1.id })
    expect(notification.read_by?(user1)).to eq(notification_user.read)
  end

  it 'sets the value of read to true'do
    notification.set_read_for(user1)
    notification_user= IdeaNotificationsUser.find(:first, :conditions => {idea_notification_id: notification.id, user_id: user1.id })
    expect(notification_user.read).to eq(true)
  end

end
