require 'spec_helper'
describe DashboardController do
  describe 'GET #index' do
    it review a graph of tags 'ideas' do
      ideasall = Factory(:ideasall)
      get :index
      assigns(:chart).should eq([:ideasall])
    end
    it 'renders the :index view'do
      get :index
      response.should render_template :index
    end
  end
end