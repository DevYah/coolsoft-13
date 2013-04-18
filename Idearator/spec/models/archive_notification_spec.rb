require 'spec_helper'

describe ArchiveNotification do
  it 'adds archive notification to idea_notifications table'do
    user1 = User.create(email: 'amina@gmail.com', password: '123123123', username: 'amina')
    user2 = User.create(email: 'marwa@gmail.com', password: '123123123', username: 'marwa')
    idea = Idea.create(title: 'Idea', description: 'Idea Description', problem_solved: 'Problem')
    idea.user = user1
    ArchiveNotification.send_notification(user1, idea, [user2])
    expect(IdeaNotification.last.type).to eq('ArchiveNotification')
    expect(IdeaNotification.last.idea_id).to eq(idea.id)
    expect(IdeaNotification.last.user_id).to eq(user1.id)
    expect(IdeaNotification.last.users).to include(user2)
  end
end
