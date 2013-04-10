require 'spec_helper'

describe AdminsController do
  describe 'PUT ban_unban' do
    include Devise::TestHelpers
    
    context 'admin wants to ban/unban user' do
      before :each do
        @user = FactoryGirl.create(:user)
        @user.confirm!
        @admin = FactoryGirl.build(:admin)
        @admin.confirm!
        sign_in @admin
        session[:user_id] = @user.id
      end
      
      it 'toggles ban status' do
        @ban_stat = @user.banned
        put :ban_unban
        @user.reload
        (@user.banned).should_not eql(@ban_stat)
      end
    end
    
    context 'user wants to ban/unban user' do
      before :each do
        @user = FactoryGirl.create(:user)
        @user.confirm!
        @admin = FactoryGirl.build(:admin)
        @admin.confirm!
        sign_in @admin
        session[:user_id] = @user.id
      end

      it 'doesnt toggle ban status' do
        @ban_stat = @user.banned
        put :ban_unban
        @user.reload
        (@user.banned).should eql(@ban_stat)
      end      
    end  
  end
end