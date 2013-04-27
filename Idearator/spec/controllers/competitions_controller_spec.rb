require 'spec_helper'

describe CompetitionsController do
  include Devise::TestHelpers
  before :each do
    @u1 = User.create(:email => 'u@gmail.com', :password => '123123123', :username => 'u')
    @idea = Idea.create(:title => 'title', :description => 'description', :problem_solved => 'problem_solved', :approved => true)
    @competition = Competition.create(:title => 'title', :description => 'description')
    @u1.ideas << @idea
    sign_in @u1
  end

  describe 'PUT enroll_idea' do
    context 'Success Scenario' do
      it 'adds the idea to the competition ideas list' do
        expect { put :enroll_idea, id: @idea.id, id1: @competition.id } .to change(@competition.ideas, :count).by(1)
      end
      it 'redirects to competition show page' do
        response.should redirect_to(@competition)
      end
    end
  end
end
