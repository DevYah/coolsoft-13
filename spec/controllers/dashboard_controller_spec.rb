Require 'spec_helper'

describe DashboardController do
  include Devise::TestHelpers

    context 'check if signed in' do
      before :each do
        sign_in @user
      end

    describe 'Get index' do

      it 'gets approved ideas for the committee member' do
        user = Committee.create(email: "a@a.com", password: "123123123")
        user.confirm!
        2.times do 
          idea = Idea.create(title: "title", description: "description", problem_solved: "problem_solved")
          idea.committee = user
          idea.save
        end
        assigns(:approved_ideas).should have(2).items
      end

      it 'gets own ideas for the current user' do
        user = User.create(email: "a@a.com", password: "123123123")
        user.confirm!
        2.times do 
          idea = Idea.create(title: "title", description: "description", problem_solved: "problem_solved")
          idea.committee = user
          idea.save
        end
        assigns(:approved_ideas).should have(2).items
      end
      it 'gets current threshold' do
        threshold = Threshold.create(threshold: 150)
        assigns(:threshold).should eq(150)
      end
      it 'gets previous day vote count of ideas' do
        2.times do 
          idea = Idea.create(title: "title", description: "description", problem_solved: "problem_solved")
          idea.user = @user
          vote_count = VoteCount.create(idea_id: idea.id)
        end
        assigns(:own_ideas).should have(2).items
      end
  end
end