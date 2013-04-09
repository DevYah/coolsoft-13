require 'spec_helper'

describe IdeasController do
  describe 'show ' do
    include Devise::TestHelpers
    
    context 'User  wants to like' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:comment)
        @idea.user_id = @user.id
        @idea.save
        sign_in @user
      end

    end


    context 'normal user wants to vote' do

        @user = FactoryGirl.build(:user)
        @user.confirm!
        @comment = FactoryGirl.find(:first_comment)
        @comment.num_like = @comment.num_likes + 1
        @like = Like.new 

      end

       

   end
  end
end
