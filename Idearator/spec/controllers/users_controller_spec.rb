require 'spec_helper'
describe UsersController do 
	include Devise::TestHelpers
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
	end
end