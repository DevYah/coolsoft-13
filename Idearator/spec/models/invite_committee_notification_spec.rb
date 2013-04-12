require 'spec_helper'

describe InviteCommitteeNotification do
  it 'adds invite committee notification to idea_notifications table'do
    user1 = User.create(email: 'amina@gmail.com', password: '123123123', username: 'amina')
    user2 = User.create(email: 'marwa@gmail.com', password: '123123123', username: 'marwa')
    InviteCommitteeNotification.send_notification(user1, [user2])
    expect(UserNotification.last.type).to eq('InviteCommitteeNotification')
    expect(UserNotification.last.user_id).to eq(user1.id)
    expect(UserNotification.last.users).to include(user2)
  end
end
