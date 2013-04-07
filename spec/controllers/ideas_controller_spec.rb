require 'spec_helper'

describe IdeasController do
  describe 'DELETE destroy' do
    context 'idea creator wants to delete' do
      before :each do
        @user = Factory.build(:user_one)
        @user.confirm!
        @idea = Factory.build(:idea_one)
      end

      it 'deletes the idea' do
        expect { delete :destroy, id: @idea }.to change(Idea, :count).by(-1)
      end

      it 'redirects to home' do
        delete :destroy, id: @idea
          response.should redirect_to '/'
      end
    end

    context 'normal user wants to delete idea' do
      before :each do
        @userone = Factory.build(:user_one)
        @userone.confrim!
        @usertwo = Factory.build(:user_two)
        @usertwo.confirm!
        @idea = Factory.build(:idea)
      end

      it 'deletes the idea' do
        expect { delete :destroy, id: @idea }.to change(Idea, :count).by(0)
      end

      it 'redirects to idea' do
        delete :destroy, id: @idea
        response.should redirect_to @idea
      end
    end
  end
end