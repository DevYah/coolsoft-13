require 'spec_helper'

describe NotificationsController do
  include Devise::TestHelpers
  before :each do
    @user1 = User.new(email:'amina@gmail.com', username: 'amina', password: '123123123')
    @user1.confirm!
    @user1.save

    sign_in @user1

    @user2 = User.new(email:'lina@gmail.com', username: 'lina', password: '123123123')
    @user2.confirm!
    @user2.save

    @user3 = User.new(email:'salah@gmail.com', username: 'salah', password: '123123123')
    @user3.confirm!
    @user3.save

    @idea1 = Idea.new(title: 'Idea title', description: 'Idea description', problem_solved: 'problem')
    @idea1.user = @user3
    @idea1.save

    @notification1 = EditNotification.send_notification(@user3, @idea1, [@user2, @user1])
    @notification2 = InviteCommitteeNotification.send_notification(@user2, [@user1])
    @notification3 = DisapproveIdeaNotification.send_notification(@user2, @idea1, [@user1])
    @notification4 = ApproveCommitteeNotification.send_notification(@user2, [@user1])

    @idea_notification = IdeaNotificationsUser.find(:first, :conditions => {idea_notification_id: @notification1.id, user_id: @user1.id })
    @user_notification_1 = UserNotificationsUser.find(:first, :conditions => {user_notification_id: @notification4.id, user_id: @user1.id })
    @user_notification_2 = UserNotificationsUser.find(:first, :conditions => {user_notification_id: @notification2.id, user_id: @user1.id })

  end


  describe 'GET view_all_notifications' do

    it 'gets all current user notifications' do

      get :view_all_notifications
      assigns(:all_notifications).should eq([@notification4, @notification3, @notification2, @notification1])

      response.should render_template('view_all_notifications')

    end
  end

  describe 'PUT redirect_idea' do
    it 'assigns the read value to true' do
      put :redirect_idea, :notification => @notification1.id
      @idea_notification.reload
      @idea_notification.read.should eq(true)
    end
  end

  describe 'PUT redirect_expertise' do
    it 'assigns the read value to true' do
      put :redirect_expertise, :notification => @notification2.id
      @user_notification_2.reload
      @user_notification_2.read.should eq(true)
    end
  end

  describe 'PUT redirect_review' do
    it 'assigns the read value to true' do
      put :redirect_review, :notification => @notification4.id
      @user_notification_1.reload
      @user_notification_1.read.should eq(true)
    end
  end

end