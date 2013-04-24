require 'spec_helper'

describe ApproveCommitteeNotification do
  user1 = User.create(email: 'amina@gmail.com', password: '123123123', username: 'amina')
  user2 = User.create(email: 'marwa@gmail.com', password: '123123123', username: 'marwa')
  notification = ApproveCommitteeNotification.create(user: user2, users: [user1])
  it 'adds approve committee notification to idea_notifications table'do
    ApproveCommitteeNotification.send_notification(user1, [user2])
    expect(UserNotification.last.type).to eq('ApproveCommitteeNotification')
    expect(UserNotification.last.user_id).to eq(user1.id)
    expect(UserNotification.last.users).to include(user2)
  end
  
  it 'returns the notifications text'do
    expect(notification.text).to eq('marwa has signed up as a committee member.')
  end

  it 'returns the value of the read variable'do
    notification_user= UserNotificationsUser.find(:first, :conditions => {user_notification_id: notification.id, user_id: user1.id })
    expect(notification.read_by?(user1)).to eq(notification_user.read)
  end

  it 'sets the value of read to true'do
    notification.set_read_for(user1)
    notification_user= UserNotificationsUser.find(:first, :conditions => {user_notification_id: notification.id, user_id: user1.id })
    expect(notification_user.read).to eq(true)
  end

end
