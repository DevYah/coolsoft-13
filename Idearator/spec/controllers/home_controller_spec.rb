require 'spec_helper'

describe HomeController do
  describe 'GET #index' do
    it 'populates an array of ideas' do
    searchresults = Factory(:approved)
    get :index, params[:search]
    assigns(:approved).should eq([searchresults])
    end
  end
end