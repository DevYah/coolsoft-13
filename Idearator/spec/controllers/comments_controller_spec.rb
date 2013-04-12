require 'spec_helper'

describe CommentsController do
  describe 'DELETE destroy' do
    include Devise::TestHelpers
    
    context 'comment creator wants to delete' do
       it 'deletes the comment' do
        @user = User.new
        @user.email = "Dayna@gmail.com"
        @user.confirm!
        @user.save
        @idea = Idea.new
        @idea.description=@idea.problem_solved=@idea.title= "Daynaaa's Idea"
        @idea.save
        @comment = Comment.new
        @comment.content ="Dayna's comment"
        @comment.user_id = @user.id
        @comment.idea_id = @idea.id
        @comment.save
        sign_in @user
        expect { delete :destroy, :id => @comment.id, :idea_id => @idea.id }.to change(Comment, :count).by(-1)
        response.should redirect_to @idea

      end
      end

      

    context 'normal user wants to delete comment' do
      it 'does not delete the comment' do
        @userone = User.new
        @userone.email = "One"
        @userone.confirm!
        @userone.save
        @usertwo = User.new
        @usertwo.email = "Two"
        @usertwo.confirm!
        @usertwo.save
        @idea = Idea.new
        @idea.description=@idea.problem_solved=@idea.title="Daynaaaaaa"
        @comment = Comment.new
        @comment.content = "Dayna's comment"
        @comment.user_id = @userone.id
        @comment.idea_id = @idea.id
        @comment.save
        sign_in @usertwo
        expect { delete :destroy, :id => @comment.id, :idea_id => @idea.id }.to change(Comment, :count).by(0)
        response.should redirect_to @idea
      end  
      end
  end
end