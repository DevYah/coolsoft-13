<<<<<<< HEAD
require "spec_helper"

describe UsersController do 
include Devise::TestHelpers
  describe "Get edit" do

    it "renders the :edit view for the specified user" do
      user = User.new
      user.id = 1
      user.email = "test@gmail.com"
      user.confirm!
      user.save
      get :edit , id: 1
      response.should render_template :edit
    end
  end

  describe "Put update" do

   it "changes the user's about_me" do
  	user = User.new
  	user.id = 2
  	user.email = "test2@gmail.com"
  	user.about_me = "Nothing"
  	user.confirm!
  	user.save
  	put :update , :id => 2 , :user => {:about_me => "new about me"}
  	user.reload
  	user.about_me.should eq("new about me")
   end
  end

  describe "Get user profile" do

    it "renders the :show view for the specified user" do
      user = User.new
      user.id = 1
      user.email = "test@gmail.com"
      user.confirm!
      user.save
      5.times do 
        i = Idea.new
        i.user_id = 1
        i.title = Faker::Name.name
        i.description = Faker::Lorem.paragraph
        i.problem_solved = Faker::Lorem.paragraph
        i.approved = "true"
        i.num_votes = rand(1..500)
        i.save
       end

      get :show, id:1
      response.should render_template :show
      assigns(:approved).should have(5).items
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