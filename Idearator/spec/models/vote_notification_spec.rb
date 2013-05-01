require 'spec_helper'

describe VoteNotification do
  before :each do
    @user = FactoryGirl.create(:user)
    @user.confirm!
    @idea = FactoryGirl.create(:idea)
    @idea.user = @user
    @notification = VoteNotification.create(user: @user, idea: @idea, users: [@user])
  end

  it 'adds vote notification to idea_notifications table'do
    VoteNotification.send_notification(@user, @idea, [@user])
    expect(IdeaNotification.last.type).to eq('VoteNotification')
    expect(IdeaNotification.last.idea_id).to eq(@idea.id)
    expect(IdeaNotification.last.user_id).to eq(@user.id)
    expect(IdeaNotification.last.users).to include(@user)
  end

  it 'returns the notifications text'do
    expect(@notification.text).to eq('Your idea idea1 got a vote.')
  end

  it 'returns the value of the read variable'do
    notification_user= NotificationsUser.find(:first, :conditions => {notification_id: @notification.id, user_id: @user.id })
    expect(@notification.read_by?(@user)).to eq(notification_user.read)
  end

  it 'sets the value of read to true'do
    @notification.set_read_for(@user)
    notification_user= NotificationsUser.find(:first, :conditions => {notification_id: @notification.id, user_id: @user.id })
    expect(notification_user.read).to eq(true)
  end

end
