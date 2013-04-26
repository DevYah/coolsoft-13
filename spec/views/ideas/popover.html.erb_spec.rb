require "spec_helper"

describe "ideas/popover" do
  # tests popover is rendered
  # Author: Dayna
  before :each do
    @user = User.new
    @user.username = 'Dayna'
    @username = @user.username
    @user.save
    @username.save
    @idea= Idea.new
    @idea.title= "idea1"
    @idea.description= "blablabla"
    @idea.problem_solved= "ay nila"
    @idea.save
  end

  it "displays popover " do
    render
    rendered.should include("<div = img ")
    rendered.should include("<div = @username")
    rendered.should include("<div = @idea.title")
    rendered.should include("<div = @idea.describtion")

  end
end
