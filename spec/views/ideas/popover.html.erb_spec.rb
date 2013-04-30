require "spec_helper"

describe "ideas/popover" do
# tests popover is rendered
# Author: Dayna
before :each do
  @user = FactoryGirl.build(:user)
  @user.confirm!
  @idea = FactoryGirl.create(:idea)
  @idea.user_id = @user.id
  @idea.save
  @vote = FactoryGirl.build(:vote)
  @vote.user_id = @user.id
  @vote.idea_id = @idea.id
  @vote.save
end
it "has a button vote" do
  render :template => "/ideas/_popover", :locals => {:idea => @idea , :vote =>@vote ,:user_id => @user}
  rendered.should have_button('vote')
end
end

