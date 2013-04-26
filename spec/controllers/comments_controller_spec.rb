require 'spec_helper'
describe IdeasController do
  include Devise::TestHelpers

  describe 'POST comment' do
    context 'logged in user wants to comment' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        sign_in @user
      end

      it 'increments comments counter' do
        expect { post :comment, :id => @idea.id }.to change(Comment, :count).by(1)
      end
    end

    context 'not logged in user wants to comment' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
      end

      it 'does not increment the comments counter' do
        expect { post :comment, :id => @idea.id }.to change(Comment, :count).by(0)
      end
    end
  end

  describe 'DELETE destroy' do
    context 'logged in user wants to delete comment' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        sign_in @user
      end

      it 'decrements comments counter' do
        expect { delete :destroy, :id => @idea.id }.to change(Comment, :count).by(-1)
      end
    end

    context 'not logged in user wants to comment' do
      before :each do
        @idea = FactoryGirl.create(:idea)
      end

      it 'does not decrement the comments counter' do
        expect { delete :destroy, :id => @idea.id }.to change(Comment, :count).by(0)
      end
    end
  end
end
