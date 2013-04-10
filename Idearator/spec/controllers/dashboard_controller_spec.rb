require 'spec_helper'

describe DashboardController do

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
      ideas = []
      20.times do
        i = Idea.new
        i.user_id = l.id
        i.title = Faker::Name.name
        i.description = Faker::Lorem.paragraph
        i.problem_solved = Faker::Lorem.paragraph
        i.approved = 'true'
        i.num_votes = rand(1..500)
        i.save
        ideas+=[i]
        tagidea = IdeasTags.new
        tagidea.tag_id = tag.id
        tagidea.idea_id = i.id
        tagidea.save
      end
      get :graph, :ideas => ideas
      assigns(:data_table).should have(20).items
    end
  end
end
