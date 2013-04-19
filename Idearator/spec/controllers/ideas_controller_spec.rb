require 'spec_helper'

describe IdeasController do
  describe 'PUT archive' do
    include Devise::TestHelpers

    context 'idea creator wants to archive' do
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

      it 'archives the idea' do
        put :archive, :id => @idea.id, :format => 'js'
        @idea.reload
        (@idea.archive_status).should eql(true)
      end

      it 'deletes idea comments' do
        expect { put :archive, :id => @idea.id, :format => 'js' }.to change(Comment, :count).by(-1)
      end

      it 'deletes idea votes' do
        expect { put :archive, :id => @idea.id, :format => 'js' }.to change(Vote, :count).by(-1)
      end
    end

    context 'admin wants to archive' do
      before :each do
        @admin = FactoryGirl.build(:admin)
        @admin.confirm!
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
        sign_in @admin
      end

      it 'archives the idea' do
        put :archive, :id => @idea.id, :format => 'js'
        @idea.reload
        (@idea.archive_status).should eql(true)
      end

      it 'deletes idea comments' do
        expect { put :archive, :id => @idea.id, :format => 'js' }.to change(Comment, :count).by(-1)
      end

      it 'deletes idea votes' do
        expect { put :archive, :id => @idea.id, :format => 'js' }.to change(Vote, :count).by(-1)
      end
    end

    context 'normal user wants to archive' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        sign_in @user
      end

      it 'does not archive the idea' do
        @arch_stat = @idea.archive_status
        put :archive, :id => @idea.id, :format => 'js'
        @idea.reload
        (@idea.archive_status).should eql(@arch_stat)
      end

      it 'does not delete idea votes' do
        expect { put :archive, :id => @idea.id, :format => 'js' }.to change(Vote, :count).by(0)
      end

      it 'does not delete idea comments' do
        expect { put :archive, :id => @idea.id, :format => 'js' }.to change(Comment, :count).by(0)
      end
    end
  end

  describe 'PUT unarchive' do
    include Devise::TestHelpers

    context 'idea creator wants to unarchive' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        @idea.user_id = @user.id
        @idea.save
        sign_in @user
      end

      it 'unarchives the idea' do
        put :unarchive, :id => @idea.id, :format => 'js'
        @idea.reload
        (@idea.attributes['archive_status']).should eql(false)
      end
    end

    context 'admin wants to unarchive' do
      before :each do
        @admin = FactoryGirl.build(:admin)
        @admin.confirm!
        @idea = FactoryGirl.create(:idea)
        sign_in @admin
      end

      it 'unarchives the idea' do
        put :unarchive, :id => @idea.id, :format => 'js'
        @idea.reload
        (@idea.archive_status).should eql(false)
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
        @arch_stat = @idea.archive_status
        put :unarchive, :id => @idea.id, :format => 'js'
        @idea.reload
        (@idea.archive_status).should eql(@arch_stat)
      end
    end
  end
end