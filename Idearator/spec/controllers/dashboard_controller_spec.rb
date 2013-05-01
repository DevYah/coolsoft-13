require 'spec_helper'
include Devise::TestHelpers
describe DashboardController do
  describe 'Get index' do
    before :each do
        @user = Committee.create(email: 'test@test.com', password: 123123123)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        @idea.approved = true
        @idea.committee = @user
        @idea.user = @user
        @idea.save
        @idea_2 = FactoryGirl.create(:idea)
        @idea_2.approved = true
        @idea_2.committee = @user
        @idea_2.user = @user
        @idea_2.save
        VoteCount.create(:idea_id => @idea.id)
        VoteCount.create(:idea_id => @idea_2.id)
        @threshold = Threshold.create(:threshold => 50)
        sign_in @user
    end
    it 'gets own ideas for the current user' do
      get :index
      assigns(:own_ideas).should have(2).items
    end

    it 'gets approved ideas for the committee member' do
      get :index
      assigns(:approved_ideas).should have(2).items
    end
    it 'gets current threshold' do
      get :index
      assigns(:threshold).threshold.should eq(50)
    end
    it 'gets previous day vote count of ideas' do
      get :index
      assigns(:own_thresholds).should have(2).items
    end
  end
end