require 'spec_helper'

describe CompetitionsController do
  include Devise::TestHelpers
  before :each do
    @u1 = User.new(:email => 'u@gmail.com', :password => '123123123', :username => 'u')
    @u1.confirm!
    @u1.save
    @i1 = Investor.new(:email => 'i@gmail.com', :password => '123123123', :username => 'i')
    @i1.confirm!
    @i1.save
    @idea = Idea.create(:title => 'title', :description => 'description', :problem_solved => 'problem_solved', :approved => true)
    @competition = Competition.create(:title => 'title', :description => 'description')
    @competition.investor = @i1
    @competition.save
    @u1.ideas << @idea
    sign_in @u1
  end

  describe 'PUT enroll_idea' do
    context 'Success Scenario' do
      it 'retrieves valid competition and idea id from :id and :id1' do
        put :enroll_idea, :id => @idea.id, :id1 => @competition.id
        assigns(:idea).should_not eq(nil)
        assigns(:competition).should_not eq(nil)
      end
      it 'adds the idea to the competition ideas list' do
        expect { put :enroll_idea, id: @idea.id, id1: @competition.id } .to change(@competition.ideas, :count).by(1)
      end
      it 'calls send_notification in EnterIdeaCompetition' do
        expect { put :enroll_idea, id: @idea.id, id1: @competition.id } .to change(EnterIdeaNotification, :count).by(1)
      end
      it 'redirects to competition show page' do
        put :enroll_idea, id: @idea.id, id1: @competition.id
        response.should redirect_to "/competitions/#{@competition.id}"
      end
    end
    context 'Failure Scenario' do
      it 'does not append competitions list if idea is already in competition' do
        put :enroll_idea, id: @idea.id, id1: @competition.id
        @competition.reload
        expect { put :enroll_idea, id: @idea.id, id1: @competition.id }.to change(@competition.ideas, :count).by(0)
      end
    end
  end
end
