require 'spec_helper'

describe IdeasController do
  describe 'PUT vote' do
    include Devise::TestHelpers
    
    context 'idea creator wants to vote' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        @idea.user_id = @user.id
        @idea.save
        sign_in @user
      end

      it 'archives the idea' do
        @ideavoted = @user.votes.detect { |w|w.id == @idea.id }
        put :vote, :id => @idea.id
        @idea.reload
        (@ideavoted).should eql(@idea.id)
      end

      it 'redirects to idea' do
        put :archive, :id => @idea.id
        response.should redirect_to @idea
      end
    end

    context 'admin wants to archive' do
      before :each do
        @admin = FactoryGirl.build(:admin)
        @admin.confirm!
        @idea = FactoryGirl.create(:idea)
        sign_in @admin
      end

      it 'votes for the idea the idea' do
        @ideavoted = @admin.votes.detect { |w|w.id == @idea.id }
        put :vote, :id => @idea.id
        @idea.reload
        (@ideavoted).should eql(@idea.id)
      end

      it 'redirects to idea' do
        put :archive, :id => @idea.id
        response.should redirect_to @idea
      end
    end

    context 'normal user wants to vote' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        sign_in @user
      end

      it 'does vote for the idea' do
        @ideavoted = @user.votes.detect { |w|w.id == @idea.id }
        put :vote, :id => @idea.id
        @idea.reload
        (@ideavoted).should eql(@idea.id)
      end

      it 'redirects to idea' do
        put :vote, :id => @idea.id
        response.should redirect_to @idea
      end
    end
  end

  describe 'PUT unvote' do
    include Devise::TestHelpers
    
    context 'idea creator wants to unvote' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        @idea.user_id = @user.id
        @idea.save
        sign_in @user
      end

      it 'unvote the idea' do
        @ideavoted = @user.votes.detect { |w|w.id == @idea.id }
        put :unvote, :id => @idea.id
        @idea.reload
        (@ideavoted).should eql(nil)
      end

      it 'redirects to idea' do
        put :unvote, :id => @idea.id
        response.should redirect_to @idea
      end
    end

    context 'admin wants to unvote' do
      before :each do
        @admin = FactoryGirl.build(:admin)
        @admin.confirm!
        @idea = FactoryGirl.create(:idea)
        sign_in @admin
      end

      it 'unarchives the idea' do
       @ideavoted = @admin.votes.detect { |w|w.id == @idea.id }
        put :unvote, :id => @idea.id
        @idea.reload
        (@ideavoted).should eql(nil)
      end

      it 'redirects to idea' do
        put :unvote, :id => @idea.id
        response.should redirect_to @idea
      end
    end

    context 'normal user wants to unarchive' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        sign_in @user
      end

      it 'does not unarchive the idea' do
        @ideavoted = @user.votes.detect { |w|w.id == @idea.id }
        put :unvote, :id => @idea.id
        @idea.reload
        (@ideavoted).should eql(nil)
      end

      it 'redirects to idea' do
           put :unvote, :id => @idea.id
        response.should redirect_to @idea
      end
    end
  end
end