require 'spec_helper'

describe ApplicationController do
  describe 'Get #load_notifications' do
    it 'gets first 10 current users notifications' do
      notifications = Factory(:@notifications)
      get :load_notifications
      assigns (:@notifications).sould eq([notifications])
    end
    it 'renders the _view_notifications partial view' do
      get :_view_notifications
      response.should render_template :_view_notifications
    end
  end
end