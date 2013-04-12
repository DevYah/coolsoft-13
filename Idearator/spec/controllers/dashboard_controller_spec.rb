require 'spec_helper'

describe DashboardController do
  include Devise::TestHelpers

    describe 'Get index' do

      it 'gets own ideas for the current user' do
        user = User.create(email: "ae@a.com", password: "123123123")
        user.confirm!
        user.save
        sign_in user
        2.times do 
          idea = Idea.create(title: "title", description: "description", problem_solved: "problem_solved")
          idea.approved = true
          idea.user = user
          idea.save
          v = VoteCount.new
          v.idea = idea
          v.save 
        end
          t = Threshold.new
          t.threshold = 120
          t.save
        get :index
        assigns(:own_ideas).should have(2).items
      end

      it 'gets approved ideas for the committee member' do
        user = Committee.create(email: "ae@a.com", password: "123123123")
        user.confirm!
        user.save
        sign_in user
        2.times do 
          idea = Idea.create(title: "title", description: "description", problem_solved: "problem_solved")
          idea.approved = true
          idea.committee = user
          idea.save
          v = VoteCount.new
          v.idea = idea
          v.save 
        end
          t = Threshold.new
          t.threshold = 120
          t.save
        get :index
        assigns(:approved_ideas).should have(2).items
      end
      it 'gets current threshold' do
        user = Committee.create(email: "ae@a.com", password: "123123123")
        user.confirm!
        user.save
        sign_in user
        2.times do 
          idea = Idea.create(title: "title", description: "description", problem_solved: "problem_solved")
          idea.approved = true
          idea.committee = user
          idea.save
          v = VoteCount.new
          v.idea = idea
          v.save 
        end
          t = Threshold.new
          t.threshold = 120
          t.save
        get :index
        assigns(:threshold).threshold.should eq(120)
      end
      it 'gets previous day vote count of ideas' do
        user = User.create(email: "ae@a.com", password: "123123123")
        user.confirm!
        user.save
        sign_in user
        2.times do 
          idea = Idea.create(title: "title", description: "description", problem_solved: "problem_solved")
          idea.approved = true
          idea.user = user
          idea.save
          v = VoteCount.new
          v.idea = idea
          v.save 
        end
          t = Threshold.new
          t.threshold = 120
          t.save
        get :index
        assigns(:own_thresholds).should have(2).items
      end
  end
end