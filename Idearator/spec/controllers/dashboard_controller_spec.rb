require 'spec_helper'

describe DashboardController do
  include Devise::TestHelpers

  describe 'GET #graph' do
    it 'returns chart  ' do
      l=User.new
      l.email = "lina@gmail.com"
      l.password = "123123123"
      l.first_name = "lina"
      l.save
      tag = Tag.new
      tag.name = "tag"
      tag.save
      sign_in l

      20.times do
        i = Idea.new
        i.user_id = l.id
        i.title = Faker::Name.name
        i.description = Faker::Lorem.paragraph
        i.problem_solved = Faker::Lorem.paragraph
        i.approved = 'true'
        i.num_votes = rand(1..500)
        i.save
      
        tagidea = IdeasTags.new
        tagidea.tag_id = tag.id
        tagidea.idea_id = i.id
        tagidea.save
      end 
      get :graph, :tagid => tag.id
      assigns(:no).should eq(20)
    end
  end
end
