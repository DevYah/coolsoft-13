require 'spec_helper'

describe CompetitionsController do

  describe "GET #index" do
    before :each do
      @investor = FactoryGirl.create(:investor)
      @investor.confirm!
      @investor2 = FactoryGirl.create(:investor,email: 'abuali@yahoo.com',username: 'hamed')
      @investor2.confirm!

      5.times do
        @competition1 = FactoryGirl.create(:competition,tags: [Tag.new(:name => 'Science'),Tag.new(:name => 'Games')],investor: @investor)
      end
      6.times do
        @competition2 = FactoryGirl.create(:competition,tags: [Tag.new(:name => 'Science')] ,investor: @investor2)
      end
    end

    it "returns all competitions" do
      get :index
      assigns(:competitions).should have(10).items
    end

    it "filters competitions" do
      get :index, :tags => ['a','Games']
      assigns(:competitions).should have(5).items
    end

    it "returns all competitions when tags are empty" do
      get :index, :tags => ['a']
      assigns(:competitions).should have(10).items
    end

    it "allow infinite scrolling" do
      get :index, :myPage => 2,:tags => ['a']
      assigns(:competitions).should have(1).items
    end

    it "scrolls with filtering" do
      get :index, :tags => ['a','Games'], :myPage => 2
      assigns(:competitions).should have(0).items
    end

    it "filters competitions for investor" do
      sign_in(@investor)
      get :index
      assigns(:competitions).should have(5).items
    end

  end

  describe "tests" do
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
          put :enroll_idea, :id => @competition.id, :idea_id => @idea.id
          assigns(:idea).should_not eq(nil)
          assigns(:competition).should_not eq(nil)
        end
        it 'adds the idea to the competition ideas list' do
          expect { put :enroll_idea, :id => @competition.id, :idea_id => @idea.id } .to change(@competition.ideas, :count).by(1)
        end
        it 'calls send_notification in EnterIdeaCompetition' do
          expect { put :enroll_idea, :id => @competition.id, :idea_id => @idea.id } .to change(EnterIdeaNotification, :count).by(1)
        end
        it 'redirects to competition show page' do
          put :enroll_idea, :id => @competition.id, :idea_id => @idea.id
          response.should redirect_to "/competitions/#{@competition.id}"
        end
      end
      context 'Failure Scenario' do
        it 'does not append competitions list if idea is already in competition' do
          @competition.ideas << @idea
          expect { put :enroll_idea, :id => @competition.id, :idea_id => @idea.id }.to change(@competition.ideas, :count).by(0)
        end
      end
    end
  end

end
