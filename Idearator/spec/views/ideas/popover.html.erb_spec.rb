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

it "displays popover " do
render
rendered.should include("
<div = img >")
rendered.should include("<div = @user.username >")
rendered.should include("<div = @idea.title>")
rendered.should include("<div = @idea.describtion >")

end
end

