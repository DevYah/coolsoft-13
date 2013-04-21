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
 		before :each do
    @a = Admin.new
    @a.email = 'admin@gmail.com'
    @a.username = 'admin'
    @a.password = '123123123'
    @a.confirm!
    @a.save
    sign_in @a

    @u1 = User.new
    @u1.email = 'user1@gmail.com'
    @u1.username = 'user1'
    @u1.password = '123123123'
    @u1.confirm!
    @u1.save
    sign_in @u1
  end
   describe "PUT #invite_member" do 
   	it "retrieves the user instance from :id" do
   		put :invite_member, :id => @u1.id
   		assigns(:user).should eq(@u1)
   	end
   	it "inititates the user to the committees table" do
   		put :invite_member, :id => @u1.id
   		@u1.reload
   		@u1.type.should eq("Committee")
   	end
   	it "calls InviteCommitteeNotification.send_notification(Admin, User)" do
   		expect{ put :invite_member, :id => @u1.id }.to change(InviteCommitteeNotification,:count).by(1)
   	end
   	it "redirects to home page" do
			put :invite_member, :id => @u1.id
   		response.should redirect_to '/' 
   end
 end
end