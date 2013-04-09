require 'spec_helper'

describe DashboardController do
  describe 'GET #index' do
    it 'populates an array of tags' do
    tags = Factory(:ideatags)
    get :index, :ideaid
    assigns(:ideatags).should eq([tags])
  end
    it 'renders the index view' do
      get :index, :tagid
      response.should render_template :index
    end
  end
end