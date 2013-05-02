require 'spec_helper'
include Devise::TestHelpers

RSpec.configure do |config|
  config.mock_framework = :rspec
end

describe IdeasController do
  describe 'POST create' do
    context 'twitter user wants to create a new idea' do
      before :each do
        @user = FactoryGirl.create(:user)
        @user.confirm!
        @user.provider = 'twitter'
        @user.save
        @twitter_client = Twitter::Client.new
        Twitter::Client.stub(:new).and_return(@twitter_client)
        Twitter::Client.any_instance.stub(:update).and_return(true)
        sign_in @user
      end

      it 'instantiates a connection with twitter' do
        Twitter::Client.should_receive(:new)#.and_return(true)
        post :create, :idea => FactoryGirl.attributes_for(:idea)
      end

      it 'updates his twitter status' do
        Twitter::Client.any_instance.should_receive(:update)
        post :create, :idea => FactoryGirl.attributes_for(:idea)
      end
    end
  end

  describe 'PUT vote' do
    context 'twitter user wants to vote to any idea' do
      before :each do
        @user = FactoryGirl.create(:user)
        @user.confirm!
        @user.provider = 'twitter'
        @user.save
        @idea = FactoryGirl.create(:idea)
        @idea.user_id = @user.id
        @idea.save
        @twitter_client = Twitter::Client.new
        Twitter::Client.stub(:new).and_return(@twitter_client)
        Twitter::Client.any_instance.stub(:update).and_return(true)
        sign_in @user
      end

      it 'instantiates a connection with twitter' do
        Twitter::Client.should_receive(:new)#.and_return(true)
        put :vote, :id => @idea.id
      end

      it 'updates his twitter status' do
        Twitter::Client.any_instance.should_receive(:update)
        put :vote, :id => @idea.id
      end
    end
  end

  describe 'PUT update' do
    context 'twitter user wants to update his idea' do
      before :each do
        @user = FactoryGirl.create(:user)
        @user.confirm!
        @user.provider = 'twitter'
        @user.save
        @idea = FactoryGirl.create(:idea)
        @idea.user_id = @user.id
        @idea.save
        @twitter_client = Twitter::Client.new
        Twitter::Client.stub(:new).and_return(@twitter_client)
        Twitter::Client.any_instance.stub(:update).and_return(true)
        sign_in @user
      end

      it 'instantiates a connection with twitter' do
        Twitter::Client.should_receive(:new)#.and_return(true)
        put :update, :id => @idea.id
      end

      it 'updates his twitter status' do
        Twitter::Client.any_instance.should_receive(:update)
        put :update, :id => @idea.id
      end
    end
  end

  describe 'PUT unarchive' do
    context 'twitter user wants to unarchive his idea' do
      before :each do
        @user = FactoryGirl.create(:user)
        @user.confirm!
        @user.provider = 'twitter'
        @user.save
        @idea = FactoryGirl.create(:idea)
        @idea.user_id = @user.id
        @idea.archive_status = true
        @idea.save
        @twitter_client = Twitter::Client.new
        Twitter::Client.stub(:new).and_return(@twitter_client)
        Twitter::Client.any_instance.stub(:update).and_return(true)
        sign_in @user
      end

      it 'instantiates a connection with twitter' do
        Twitter::Client.should_receive(:new)#.and_return(true)
        put :unarchive, :id => @idea.id, :format => 'js'
      end

      it 'updates his twitter status' do
        Twitter::Client.any_instance.should_receive(:update)
        put :unarchive, :id => @idea.id, :format => 'js'
      end
    end
  end
end

describe UserRatingsController do
  describe 'POST create' do
    context 'twitter user wants to rate idea' do
      before :each do
        @user = FactoryGirl.create(:user)
        @user.confirm!
        @user.provider = 'twitter'
        @user.save
        @idea = FactoryGirl.create(:idea)
        @rating = FactoryGirl.create(:rating)
        @rating.idea_id = @idea.id
        @rating.save
        @twitter_client = Twitter::Client.new
        Twitter::Client.stub(:new).and_return(@twitter_client)
        Twitter::Client.any_instance.stub(:update).and_return(true)
        sign_in @user
      end

      it 'instantiates a connection with twitter' do
        Twitter::Client.should_receive(:new)#.and_return(true)
        post :create, :idea_id => @idea.id, :rating_id => @rating.id, :rating => { :value => 5 }
      end

      it 'updates his twitter status' do
        Twitter::Client.any_instance.should_receive(:update)
        post :create, :idea_id => @idea.id, :rating_id => @rating.id, :rating => { :value => 5 }
      end
    end
  end
end