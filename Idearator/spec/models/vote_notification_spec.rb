require 'spec_helper'

describe VoteNotification do
  it 'adds vote notification to idea_notifications table'do
    user1 = User.create(email: 'amina@gmail.com')
    user2 = User.create(email: 'marwa@gmail.com')
    idea = Idea.create(title: 'Idea', description: 'Idea Description', problem_solved: 'Problem')
    idea.user = user1
    VoteNotification.send_notification(user1, idea, [user2])
    expect(IdeaNotification.last.type).to eq('VoteNotification')
    expect(IdeaNotification.last.idea_id).to eq(idea.id)
    expect(IdeaNotification.last.user_id).to eq(user1.id)
  end
end
