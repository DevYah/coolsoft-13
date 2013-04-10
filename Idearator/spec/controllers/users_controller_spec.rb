require "spec_helper"

describe UsersController do 

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



	
end