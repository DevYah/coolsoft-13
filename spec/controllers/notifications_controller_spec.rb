require 'spec_helper'

describe NotificationsController do 

  describe 'Get #view_all_notifications' do
    it 'gets all current users notifications' do
      notifications = Factory(:all_notifications)
      get :view_all_notifications
      assigns (:all_notifications).sould eq([notifications)
    end
    it 'renders the view_all_notifications view' do
      get :view_all_notifications
      response.should render_template :view_all_notifications
    end
  end

  describe 'GET #redirect_idea' do
    it 'sets the read variable to true' do
      notification = Factory(:idea_not)
      get :redirect_idea, :not_id
      assigns (:idea_not.read).sould eq(true)
    end
    it 'renders the idea/show view' do
      get :redirect_idea, :not_id
      response.should render_template :not_id.idea
    end
  end

  describe 'GET #redirect_expertise' do
    it 'sets the read variable to true' do
      notification = Factory(:user_not)
      get :redirect_idea, :not_id
      assigns (:user_not.read).sould eq(true)
    end
    it 'renders the users/expertise view' do
      get :redirect_expertise, :not_id
      response.should render_template :expertise
    end
  end

  describe 'GET #redirect_review' do
    it 'sets the read variable to true' do
      notification = Factory(:user_not)
      get :redirect_idea, :not_id
      assigns (:user_not.read).sould eq(true)
    end
    it 'renders the users/expertise view' do
      get :redirect_expertise, :not_id
      response.should render_template :review
    end
  end

end