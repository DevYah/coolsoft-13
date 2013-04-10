# spec/controllers/admins_controller_spec.rb 
require 'spec_helper'

describe UsersController do 
 	include Devise::TestHelpers
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
   describe "PUT #reject_invitation" do 
   	it "retrieves the user instance from :id" do
   		put :reject_invitation, @u1.id
   		assigns(:user).should eq(@u1.id)
   	end
   	it "removes the user from the committees table" do
   		put :reject_invitation, @u1.id 
   		@u1.reload
   		assigns(@u1.type).should eq(nil)
   	end
   	it "redirects to user's profile page" do
   		response.should redirect to @u1
   	end
   end


   describe "PUT #invite_member" do 
   	it "retrieves the user instance from :id" do
   		put :invite_member, @u1.id
   		assigns(:user).should eq(@u1.id)
   	end

   	it "inititates the user to the committees table" do
   		put :invite_member, @u1.id
   		@u1.reload
   		assigns(@u1.type).should eq("Committee")
   	end
   	it "calls InviteCommitteeNotification.send_notification(Admin, User)" do
   		expect{ put :invite_member, @u1.id }.to change(InviteCommitteeNotification,:count).by(1)
   	end
   	it "redirects to admin's index page" do
   		response.should redirect to 'admins/index' 
   end
 end
end