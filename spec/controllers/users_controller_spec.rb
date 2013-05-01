require 'spec_helper'
describe UsersController do
  include Devise::TestHelpers
  describe "PUT 'update'" do
    before(:each) do
      @user = FactoryGirl.build(:user)
      @user.first_name = 'first_name'
      @user.last_name = 'last_name'
      @user.username = 'username'
      @user.date_of_birth = Date.current()
      @user.confirm!
      sign_in @user
    end
    describe 'Success' do
      it "should change the user's attributes" do
        @attr = { :first_name => 'first_name_updated', :last_name => 'last_name_updated', :username => 'username_updated' }
        puts 'Old first_name: ' + @user.first_name
        put :update, :id => @user, :user => @attr
        @user.reload
        (@user.first_name).should eql('first_name_updated')
        (@user.last_name).should eql('last_name_updated')
        (@user.username).should eql('username_updated')
        puts 'New first_name: ' + @user.first_name
      end
    end
  end
  describe "PUT change_settings" do
    it "changes user settings" do
      u= User.new
      u.email="test1@gmail.com"
      u.username= "sameh"
      u.password= "123123123"
      u.confirm!
      u.save
      sign_in u
      put :change_settings, :user=> ['1']
      u.reload
      u.own_idea_notifications.should eq(true)
      u.participated_idea_notifications.should eq(false)
    end
    it "changes user settings" do
      u1= User.new
      u1.email="test1@gmail.com"
      u1.username= "sameh"
      u1.password= "123123123"
      u1.confirm!
      u1.save
      sign_in u1
      put :change_settings, :user=> []
      u1.reload
      u1.own_idea_notifications.should eq(false)
      u1.participated_idea_notifications.should eq(false)
    end
  end
end
