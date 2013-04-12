require 'spec_helper'

describe IdeasController do
  describe 'DELETE destroy' do
    include Devise::TestHelpers
    
    context 'idea creator wants to delete' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        @idea.user_id = @user.id
        @idea.save
        @comment = FactoryGirl.build(:comment)
        @comment.user_id = @user.id
        @comment.idea_id = @idea.id
        @comment.save
        @vote = FactoryGirl.build(:vote)
        @vote.user_id = @user.id
        @vote.idea_id = @idea.id
        @vote.save
        sign_in @user
      end

      it 'deletes the idea' do
        expect { delete :destroy, :id => @idea.id }.to change(Idea, :count).by(-1)
      end

      it 'redirects to home' do
        delete :destroy, :id => @idea.id
        response.should redirect_to '/'
      end

      it 'deletes idea comments' do
        expect { delete :destroy, :id => @idea.id }.to change(Comment, :count).by(-1)
      end

      it 'deletes idea votes' do
        expect { delete :destroy, :id => @idea.id }.to change(Vote, :count).by(-1)
      end
    end

    context 'normal user wants to delete idea' do
      before :each do
        @userone = FactoryGirl.build(:user)
        @userone.confirm!
        @usertwo = FactoryGirl.build(:user_two)
        @usertwo.confirm!
        @idea = FactoryGirl.create(:idea)
        @idea.user_id = @userone.id
        @idea.save
        @comment = FactoryGirl.build(:comment)
        @comment.user_id = @userone.id
        @comment.idea_id = @idea.id
        @comment.save
        @vote = FactoryGirl.build(:vote)
        @vote.user_id = @userone.id
        @vote.idea_id = @idea.id
        @vote.save
        sign_in @usertwo
      end

      it 'does not delete the idea' do
        expect { delete :destroy, :id => @idea.id }.to change(Idea, :count).by(0)
      end

      it 'redirects to idea' do
        delete :destroy, :id => @idea.id
        response.should redirect_to @idea
      end

      it 'does not delete idea comments' do
        expect { delete :destroy, :id => @idea.id }.to change(Comment, :count).by(0)
      end

      it 'does not delete idea votes' do
        expect { delete :destroy, :id => @idea.id }.to change(Vote, :count).by(0)
      end
    end
  end
end