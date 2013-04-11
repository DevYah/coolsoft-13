require 'spec_helper'

describe ApproveCommitteeNotification do
  it 'adds approve committee notification to idea_notifications table'do
    user1 = User.create(email: 'amina@gmail.com')
    user2 = User.create(email: 'marwa@gmail.com')
    ApproveCommitteeNotification.send_notification(user1, [user2])
    expect(UserNotification.last.type).to eq('ApproveCommitteeNotification')
    expect(UserNotification.last.user_id).to eq(user1.id)
  end
end