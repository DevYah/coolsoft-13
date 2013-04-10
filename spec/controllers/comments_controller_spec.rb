require 'spec_helper'

describe CommentsController do
  describe 'DELETE destroy' do
    include Devise::TestHelpers
    
    context 'comment creator wants to delete' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        @comment = FactoryGirl.create(:comment)
        @comment.user_id = @user.id
        @comment.idea_id = @idea.id
        @comment.save
        sign_in @user
      end

      it 'deletes the comment' do
        expect { delete :destroy, :id => @comment.id, :idea_id => @idea.id }.to change(Comment, :count).by(-1)
      end

      it 'redirects to home' do
        delete :destroy, :id => @comment.id, :idea_id => @idea.id
          response.should redirect_to @idea
      end
    end

    context 'normal user wants to delete comment' do
      before :each do
        @userone = FactoryGirl.build(:user)
        @userone.confirm!
        @usertwo = FactoryGirl.build(:user_two)
        @usertwo.confirm!
        @idea = FactoryGirl.create(:idea)
        @comment = FactoryGirl.create(:comment)
        @comment.user_id = @userone.id
        @comment.idea_id = @idea.id
        @comment.save
        sign_in @usertwo
      end

      it 'does not delete the comment' do
        expect { delete :destroy, :id => @comment.id , :idea_id => @idea.id }.to change(Comment, :count).by(0)
      end

      it 'redirects to idea' do
        delete :destroy, :id => @comment.id , :idea_id => @idea.id
        response.should redirect_to @idea
      end
    end
  end
end