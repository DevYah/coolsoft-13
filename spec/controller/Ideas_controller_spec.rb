require 'spec_helper'

describe IdeasController do
  describe 'show ' do
    include Devise::TestHelpers



    context 'normal user wants to like' do

        @user = User.new
        @user.email = "daynsdgshddddgshdgsdsgdhsda@gmail.com"
        @user.confirm!
        @user.save
        idea = Idea.new
        idea.title = idea.description = idea.problem_solved = "Dayna"
        idea.save
        @comment = Comment.new
        @comment.content = "dayna" 
        @comment.idea_id = @idea.id
         @like = Like.new
         @like.user_id = @user.id
        @like.comment_id = @comment.id
        @like.save
        @comment.num_likes = @comment.num_likes + 1
        get :show , :commentid => @comment.id
        @idea.reload
      end


   end
  end

