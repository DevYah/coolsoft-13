require 'spec_helper'

describe HomeController do

  describe 'GET index' do

    it 'succeeds' do
      get :index
      response.should be_success
    end
    it 'returns top ten ' do
      20.times do
        i = Idea.new
        i.user_id = rand(1..40)
        i.title = Faker::Name.name
        i.description = Faker::Lorem.paragraph
        i.problem_solved = Faker::Lorem.paragraph
        i.approved = 'true'
        i.num_votes = rand(1..500)
        i.save
      end
      get :index , :page => 1
      response.should be_success
      assigns(:top).should have(10).items
    end
  end
end
