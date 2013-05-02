require 'spec_helper'

describe CommentNotification do
before :each do
    @user = FactoryGirl.create(:user)
    @user.confirm!
    @idea = FactoryGirl.create(:idea)
    @idea.user = @user
    @notification = CommentNotification.create(user: @user, idea: @idea, users: [@user])
  end

  describe 'send_notification' do

    it 'adds comment notification to idea_notifications table'do
      CommentNotification.send_notification(@user, @idea, [@user])
      expect(IdeaNotification.last.type).to eq('CommentNotification')
      expect(IdeaNotification.last.idea_id).to eq(@idea.id)
      expect(IdeaNotification.last.user_id).to eq(@user.id)
      expect(IdeaNotification.last.users).to include(@user)
    end

    it 'adds comment notification to notifications table' do
      expect(Notification.last.subtype).to eq ('CommentNotification')
    end

  end

  describe 'text' do

    it 'returns the notifications text'do
      expect(@notification.text).to eq('user commented on your idea idea1.')
    end
  end

  describe 'read_by?' do

    it 'returns the value of the read variable'do
      notification_user= NotificationsUser.find(:first, :conditions => {notification_id: @notification.id, user_id: @user.id })
      expect(@notification.read_by?(@user)).to eq(notification_user.read)
    end

  end

  describe 'set_read_for' do

    it 'sets the value of read to true'do
      @notification.set_read_for(@user)
      notification_user= NotificationsUser.find(:first, :conditions => {notification_id: @notification.id, user_id: @user.id })
      expect(notification_user.read).to eq(true)
    end

  end

end
