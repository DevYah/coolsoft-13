require 'spec_helper'

describe NotificationsController do
  include Devise::TestHelpers
  before :each do
    @u1 = User.new
    @u1.email = 'amina@gmail.com'
    @u1.username = 'amina'
    @u1.password = '123123123'
    @u1.confirm!
    @u1.save

    sign_in @u1

    @u2 = User.new
    @u2.email = 'lina@gmail.com'
    @u2.username = 'lina'
    @u2.password = '123123123'
    @u2.confirm!
    @u2.save

    @u3 = User.new
    @u3.email = 'salah@gmail.com'
    @u3.username = 'salah'
    @u3.password = '123123123'
    @u3.confirm!
    @u3.save

    @i1 = Idea.new
    @i1.title = 'Idea title'
    @i1.description = 'Idea description'
    @i1.problem_solved = 'problem'
    @i1.user = @u3
    @i1.save

    @not1 = EditNotification.send_notification(@u3, @i1, [@u2, @u1])
    @not2 = InviteCommitteeNotification.send_notification(@u2, [@u1])
    @not3 = DisapproveIdeaNotification.send_notification(@u2, @i1, [@u1])
    @not4 = ApproveCommitteeNotification.send_notification(@u2, [@u1])

    @idea_not = IdeaNotificationsUser.find(:first, :conditions => {idea_notification_id: @not1.id, user_id: @u1.id })
    @user_not_1 = UserNotificationsUser.find(:first, :conditions => {user_notification_id: @not4.id, user_id: @u1.id })
    @user_not_2 = UserNotificationsUser.find(:first, :conditions => {user_notification_id: @not2.id, user_id: @u1.id })

  end


  describe 'GET view_all_notifications' do

    it 'gets all current user notifications' do

      get :view_all_notifications
      assigns(:all_notifications).should eq([@not4, @not3, @not2, @not1])

      response.should render_template('view_all_notifications')

    end
  end

  describe 'PUT redirect_idea' do

    it 'assigns the read value to true and redirects to idea/id' do

      put :redirect_idea, :not_id => @not1.id
      @idea_not.reload
      @idea_not.read.should eq(true)

      response.should redirect_to @i1

    end
  end


  describe 'PUT redirect_expertise' do

    it 'assigns the read value to true and redirects to idea/id' do

      put :redirect_expertise, :not_id => @not2.id
      @user_not_2.reload
      @user_not_2.read.should eq(true)

      response.should redirect_to(controller: 'users', action: 'expertise')

    end
  end


  describe 'PUT redirect_review' do

    it 'assigns the read value to true and redirects to idea/id' do

      put :redirect_review, :not_id => @not4.id
      @user_not_1.reload
      @user_not_1.read.should eq(true)

      response.should redirect_to @u2

    end
  end

end