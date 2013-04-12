require 'spec_helper'

describe ApproveCommitteeNotification do
  it 'adds approve committee notification to idea_notifications table'do
    user1 = User.create(email: 'amina@gmail.com', password: '123123123', username: 'amina')
    user2 = User.create(email: 'marwa@gmail.com', password: '123123123', username: 'marwa')
    idea = Idea.create(title: 'Idea', description: 'Idea Description', problem_solved: 'Problem')
    ApproveCommitteeNotification.send_notification(user1, [user2])
    expect(UserNotification.last.type).to eq('ApproveCommitteeNotification')
    expect(UserNotification.last.user_id).to eq(user1.id)
    expect(UserNotification.last.users).to include(user2)
  end
end