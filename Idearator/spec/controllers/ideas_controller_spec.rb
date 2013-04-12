require 'spec_helper'

describe IdeasController do
      include Devise::TestHelpers

   it 'show ' do
        @user = User.new
        @user.email = "119ggpkkkkkq@gmail.com"
        @user.confirm!
        @user.save
        idea = Idea.new
        idea.title = idea.description = idea.problem_solved = "Dayna"
        idea.save
        @comment = Comment.new
        @comment.content = "dayna" 
        @comment.idea_id = idea.id
        @comment.num_likes = 0
        @comment.save
         @like = Like.new
         @like.user_id = @user.id
        @like.comment_id = @comment.id
        @like.save
        sign_in @user
        get :show , :id => idea.id , :commentid => @comment.id
        @comment.reload
        @comment.num_likes.should eq(1)

   end
 end

