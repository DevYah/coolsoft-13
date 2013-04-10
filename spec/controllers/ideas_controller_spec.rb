require 'spec_helper'

describe IdeasController do
  describe 'PUT vote' do
    include Devise::TestHelpers
    context 'user wants to vote' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        @idea.user_id = @user.id
        @idea.save
        sign_in @user
      end
      it 'idea id in user.votes' do
        put :vote, :id => @idea.id
        @idea.reload
        @voted = @user.votes.find(@idea)
        (@voted.id).should eql(@idea.id)
      end
      it 'redirects to idea' do
        put :vote, :id => @idea.id
        response.should redirect_to @idea
      end
      it 'increase idea votes' do
        @numvotes = @idea.num_votes+1
        put :vote, :id => @idea.id
        @idea.reload
        (@numvotes).should eql(@idea.num_votes)
      end
    end
    
    context 'user wants to unvote' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        @idea.user_id = @user.id
        @idea.save
        sign_in @user
      end

      it 'idea id deleted from user.votes' do
        put :unvote, :id => @idea.id
        @idea.reload
        @voted = @user.votes.find(:first ,:conditions => {id: @idea_id})
        (@voted).should eql(nil)
      end
      it 'redirects to idea' do
        put :unvote, :id => @idea.id
        response.should redirect_to @idea
      end
      it 'increase idea votes' do
        @numvotes=@idea.num_votes-1
        put :unvote, :id => @idea.id
        @idea.reload
        (@numvotes).should eql(@idea.num_votes)
      end
    end
  end  
end