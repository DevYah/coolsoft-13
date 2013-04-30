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
        @u=Investor.new
        @u.email='u@gmail.com'
        @u.password=123123123
        @u.username='u'
        @u.confirm!
        @u.save
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
        @idea1=Idea.new
        @idea1.title='bla'
        @idea1.description='bla'
        @idea1.problem_solved='bla'
        @idea1.save
        @idea2=Idea.new
        @idea2.title='ay7aga'
        @idea2.description='ay7aga'
        @idea2.problem_solved='ay7aga'
        @idea2.save
        @idea3=Idea.new
        @idea3.title='blablabla'
        @idea3.description='blablabla'
        @idea3.problem_solved='blablabla'
        @idea3.save
        @ce=CompetitionEntry.new
        @ce.idea_id=@idea.id
        @ce.competition_id=@c.id
        @ce.save
        @ce1=CompetitionEntry.new
        @ce1.idea_id=@idea1.id
        @ce1.competition_id=@c.id
        @ce1.approved=true
        @ce1.save
        @ce2=CompetitionEntry.new
        @ce2.idea_id=@idea2.id
        @ce2.competition_id=@c.id
        @ce2.rejected=true
        @ce2.save
        @ce2=CompetitionEntry.new
        @ce2.idea_id=@idea2.id
        @ce2.competition_id=@c.id
        @ce2.rejected=true
        @ce2.save

      end

      it 'should show the investor only the ideas on his competition that are not approved or rejected yet' do
        sign_in @i
        get :review_competitions_ideas, :id => @c.id
        assigns(:ideas).count.should eql(1)
      end

      it 'should redirect guest to home page' do
        get :review_competitions_ideas, :id => @c.id
        response.should redirect_to '/'
      end

      it 'should redirect Investor who doesnt own the Competition to home page' do
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

      it 'should change the approve status of the Competition entry' do
        sign_in @i
        get :approve, :id =>@c.id ,:idea_id => @idea.id
        @ce.reload
        @ce.approved.should eql(true)
      end

      it 'should redirect guest to home page' do
        get :approve, :id =>@c.id ,:idea_id => @idea.id
        response.should redirect_to '/'
      end

      it 'should redirect Investor who doesnt own the Competition to home page' do
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

      it 'should change the reject status of the competition entry' do
        sign_in @i
        get :reject, :id =>@c.id ,:idea_id => @idea.id
        @ce.reload
        @ce.rejected.should eql(true)
      end

      it 'should redirect guest to home page' do
        get :reject, :id =>@c.id ,:idea_id => @idea.id
        response.should redirect_to '/'
      end

      it 'should redirect Investor who doesnt own the Competition to home page ' do
        sign_in @u
        get :reject, :id =>@c.id ,:idea_id => @idea.id
        response.should redirect_to '/'
      end
    end
  end
end
