<<<<<<< HEAD
require 'spec_helper'

describe DashboardController do
  describe 'GET #gettags' do
    it 'populates one tags' do
      idea = Idea.new
      idea.title = "title"
      idea.problem_solved = "problem"
      idea.description = "description"
      idea.save
      idea1 = Idea.new
      idea1.title = "title"
      idea1.problem_solved = "problem"
      idea1.description = "description"
      idea1.save
      tag = Tag.new
      tag.name = "tag"
      tag.save
      tag1 = Tag.new
      tag1.name = "tag"
      tag1.save
      it = IdeasTags.new
      it.idea_id = idea.id
      it.tag_id = tag.id
      it.save
      it1 = IdeasTags.new
      it1.idea_id = idea.id
      it1.tag_id = tag1.id
      it1.save
      get :gettags, :ideaid => idea.id
      assigns(:ideatags).size.should eq(2)
    end
     it 'populates 0 tags' do
      idea = Idea.new
      idea.title = "title"
      idea.problem_solved = "problem"
      idea.description = "description"
      idea.save
      idea1 = Idea.new
      idea1.title = "title"
      idea1.problem_solved = "problem"
      idea1.description = "description"
      idea1.save
      tag = Tag.new
      tag.name = "tag"
      tag.save
      tag1 = Tag.new
      tag1.name = "tag"
      tag1.save
      it = IdeasTags.new
      it.idea_id = idea.id
      it.tag_id = tag.id
      it.save
      it1 = IdeasTags.new
      it1.idea_id = idea.id
      it1.tag_id = tag1.id
      it1.save
      get :gettags, :ideaid => idea1.id
      assigns(:ideatags).size.should eq(0)
    end
  end
end
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