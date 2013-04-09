require 'spec_helper'

describe InviteCommitteeNotification do
  it 'adds invite committee notification to idea_notifications table'do
    user1 = User.create(email: 'amina@gmail.com')
    user2 = User.create(email: 'marwa@gmail.com')
    InviteCommitteeNotification.send_notification(user1, idea, [user2])
    expect(UserNotification.last.type).to eq('InviteCommitteeNotification')
    expect(UserNotification.last.idea_id).to eq(idea.id)
    expect(UserNotification.last.user_id).to eq(user.id)
  end
end
