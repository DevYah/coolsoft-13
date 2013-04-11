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
        @comment.save
         @like = Like.new
         @like.user_id = @user.id
        @like.comment_id = @comment.id
        @like.save
        @comment.num_likes = @comment.num_likes + 1
        get :show ,:idea_id  => idea.id , :id => @comment.id 
   end
 end

