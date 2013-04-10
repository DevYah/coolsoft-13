require 'spec_helper'

describe AdminsController do

  describe "GET invite committee" do

    it 'checks existing users' do
      u = Admin.new
      u.email = 'abuali@yahoo.com'
      u.first_name = 'f'
      u.username = 'k'
      u.password = 123123123
      u.confirm!
      u.save
      sign_in(u)      
      u.should be_valid      
      get :invite_committee , :email => u.email
      assigns(:messege).should == 'user already exists'
    end
    it 'checks existing invitations' do
      u = Admin.new
      u.email = 'abuali@yahoo.com'
      u.first_name = 'f'
      u.username = 'k'
      u.password = 123123123
      u.confirm!
      u.save
      sign_in(u)      
      u.should be_valid      
      get :invite_committee , :email => 'sayed@yahoo.com'
      get :invite_committee , :email => 'sayed@yahoo.com'
      assigns(:messege).should_not == 'success'
    end
    it 'sends invitation' do
      u = Admin.new
      u.email = 'abuali@yahoo.com'
      u.first_name = 'f'
      u.username = 'k'
      u.password = 123123123
      u.confirm!
      u.save
      sign_in(u)      
      u.should be_valid      
      get :invite_committee , :email => 'sayed@yahoo.com'
      assigns(:messege).should == 'success'
    end
  end
end