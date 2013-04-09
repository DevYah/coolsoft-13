
require 'spec_helper'
describe HomeController do
  describe 'GEt #index' do
    it 'populates an array of Top ten ideas' do
    top = Factory(:top)
    get :index
    assigns(:top).should eq([top])
  end
  it 'renders the :index view' do
    get :index
    response.should render_template :index
  end
  end
end