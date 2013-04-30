require 'spec_helper'

describe CompetitionsController do
  include Devise::TestHelpers

  describe 'Review Competition Idea' do
    context 'User wants to review ideas' do
      before :each do
        @i=Investor.new
        @i.email='i.gmail.com'
        @i.password=123123123
        @i.username='i'
        @i.confirm!
        @i.save
        @c=Competition.new
        @c.title='bla'
        @c.description='bla'
        @c.investor_id=@i.id
        @c.save
        @idea=Idea.new
        @idea.title='blabla'
        @idea.description='blabla'
        @idea.problem_solved='blabla'
        @idea.save
        @ce=CompetitionEntry.new
        @ce.idea_id=@idea.id
        @ce.competition_id=@c.id
        @ce.save
        @u=Investor.new
        @u.email='u@gmail.com'
        @u.password=123123123
        @u.username='u'

      end

      it 'Investor review the ideas' do
        sign_in @i
        get :review_competitions_ideas, :id => @c.id
        assigns(:ideas).count.should eql(1)
      end
      it 'guest should redirect to home page' do
        get :review_competitions_ideas, :id => @c.id
        response.should redirect_to '/'
      end
      it 'Investor who doesnt own the Competition should redirect to home page' do
        sign_in @u
        get :review_competitions_ideas, :id => @c.id
        response.should redirect_to '/'
      end
    end
  end
  describe 'approve' do
    context 'approving a certain idea to enter the competition' do
      before :each do
        @i=Investor.new
        @i.email='i.gmail.com'
        @i.password=123123123
        @i.username='i'
        @i.confirm!
        @i.save
        @c=Competition.new
        @c.title='bla'
        @c.description='bla'
        @c.investor_id=@i.id
        @c.save
        @idea=Idea.new
        @idea.title='blabla'
        @idea.description='blabla'
        @idea.problem_solved='blabla'
        @idea.save
        @ce=CompetitionEntry.new
        @ce.idea_id=@idea.id
        @ce.competition_id=@c.id
        @ce.save
        @u=Investor.new
        @u.email='u@gmail.com'
        @u.password=123123123
        @u.username='u'

      end
      it 'Competition Investor change the approve status of the Competition entry' do
        sign_in @i
        get :approve, :id =>@c.id ,:idea_id => @idea.id
        @ce.reload
        @ce.approved.should eql(true)
      end
      it 'guest redirect to home page' do
        get :approve, :id =>@c.id ,:idea_id => @idea.id
        response.should redirect_to '/'
      end
      it 'Investor who doesnt own the Competition doesnt change the approve status of the Competition Entry' do
        sign_in @u
        get :approve, :id =>@c.id ,:idea_id => @idea.id
        response.should redirect_to '/'
      end

    end
  end
  describe 'reject' do
    context 'rejecting the participation of a certain idea in the competition' do
      before :each do
        @i=Investor.new
        @i.email='i.gmail.com'
        @i.password=123123123
        @i.username='i'
        @i.confirm!
        @i.save
        @c=Competition.new
        @c.title='bla'
        @c.description='bla'
        @c.investor_id=@i.id
        @c.save
        @idea=Idea.new
        @idea.title='blabla'
        @idea.description='blabla'
        @idea.problem_solved='blabla'
        @idea.save
        @ce=CompetitionEntry.new
        @ce.idea_id=@idea.id
        @ce.competition_id=@c.id
        @ce.save
        @u=Investor.new
        @u.email='u@gmail.com'
        @u.password=123123123
        @u.username='u'

      end
      it 'Competition Investor change the approve status of the Competition entry' do
        sign_in @i
        get :reject, :id =>@c.id ,:idea_id => @idea.id
        @ce.reload
        @ce.rejected.should eql(true)
      end
      it 'guest redirect to home page' do
        get :reject, :id =>@c.id ,:idea_id => @idea.id
        response.should redirect_to '/'
      end
      it 'Investor who doesnt own the Competition doesnt change the approve status of the Competition Entry' do
        sign_in @u
        get :reject, :id =>@c.id ,:idea_id => @idea.id
        response.should redirect_to '/'
      end

    end
  end
end
