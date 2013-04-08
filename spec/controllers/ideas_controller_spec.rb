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
        sign_in @user
      end

      it 'archives the idea' do
        put :archive, :id => @idea.id
        @idea.reload
        (@idea.archive_status).should eql(true)
      end

      it 'redirects to idea' do
        put :archive, :id => @idea.id
        response.should redirect_to @idea
      end
    end

    context 'admin wants to archive' do
      before :each do
        @admin = FactoryGirl.build(:admin)
        @admin.confirm!
        @idea = FactoryGirl.create(:idea)
        sign_in @admin
      end

      it 'archives the idea' do
        put :archive, :id => @idea.id
        @idea.reload
        (@idea.archive_status).should eql(true)
      end

      it 'redirects to idea' do
        put :archive, :id => @idea.id
        response.should redirect_to @idea
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
        put :archive, :id => @idea.id
        @idea.reload
        (@idea.archive_status).should eql(@arch_stat)
      end

      it 'redirects to idea' do
        put :archive, :id => @idea.id
        response.should redirect_to @idea
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
        put :unarchive, :id => @idea.id
        @idea.reload
        (@idea.attributes['archive_status']).should eql(false)
      end

      it 'redirects to idea' do
        put :unarchive, :id => @idea.id
        response.should redirect_to @idea
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
        put :unarchive, :id => @idea.id
        @idea.reload
        (@idea.archive_status).should eql(false)
      end

      it 'redirects to idea' do
        put :unarchive, :id => @idea.id
        response.should redirect_to @idea
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
        put :unarchive, :id => @idea.id
        @idea.reload
        (@idea.archive_status).should eql(@arch_stat)
      end

      it 'redirects to idea' do
        put :unarchive, :id => @idea.id
        response.should redirect_to @idea
      end
    end
  end
end