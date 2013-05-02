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

  #Test for users#approve_committee
  #Author : Mohammad Abdulkhaliq
  describe "approve-committee" do
    before :each do
      @c = Committee.new
      @c.email = 'mohammad28march1993@gmail.com'
      @c.password = '123123123'
      @c.username = 'c'
      @c.confirm!
      @c.save
      sign_in @a
    end
    it 'it sets the approved value of committee to approved' do
      put :approve_committee, :id => @c.id
      @c.reload
      expect(@c.approved).to eq(true)
    end
    it 'redirects to admins index page' do
      put :approve_committee, :id => @c.id
      response.should redirect_to("/")
    end
  end

  #Test for users#reject_committee
  #Author : Mohammad Abdulkhaliq
  describe "reject_committee" do
    before :each do
      @c = Committee.new
      @c.email = 'mohammad28march1993@gmail.com'
      @c.password = '123123123'
      @c.username = 'c'
      @c.confirm!
      @c.save
      sign_in @a
    end
    it 'it sets the type of user to nil hence revoking his status as Comittee' do
      tm = @c.id
      put :reject_committee, :id => @c.id
      expect(User.find(tm).type).to eq(nil)
    end
    it 'redirects to admins index page' do
      put :reject_committee, :id => @c.id
      response.should redirect_to("/")
    end
  end
end
