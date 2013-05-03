require 'spec_helper'
describe StreamController do
  before :each do
  	user = Users.new 
  	user.email = "user1@gmail.com"
  	user.password = "123123123"
  	user.username = "lee7o"
  	user.first_name = "mohamed"
  	user.confirm!
  	user.save
  	

    idea = Idea.new
    idea.title = "idea1"
    idea.problem_solved = "problem"
    idea.description = "description"
    idea.approved
    idea.user_id = user.id
    idea.save

    idea1 = Idea.new
    idea1.title = "idea2"
    idea1.problem_solved = "problem"
    idea1.description = "description"
    idea1.approved
    idea1.user_id = user.id
    idea1.save

    idea2 = Idea.new
    idea2.title = "idea3"
    idea2.problem_solved = "problem"
    idea2.description = "description"
    idea2.approved
    idea2.user_id = user.id
    idea2.save
  end
  describe 'Get #index' do
    it 'populates two ideas matching the search' do
      get :index, :search => "idea2", :tag => [], :mypage => "1", :search_user => "false", :searchtype => "false",
      :insert => "true", :set_global => "false", :reset_global => "true"
      assigns(:ideas).should eq(1)
    end
  end
end