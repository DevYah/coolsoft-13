require 'spec_helper'
describe StreamController do
  before :each do
    idea = Idea.new
    idea.title = "idea1"
    idea.problem_solved = "problem"
    idea.description = "description"
    idea.approved
    idea.save
    idea1 = Idea.new
    idea1.title = "idea2"
    idea1.problem_solved = "problem"
    idea1.description = "description"
    idea1.approved
    idea1.save
    idea2 = Idea.new
    idea2.title = "idea3"
    idea2.problem_solved = "problem"
    idea2.description = "description"
    idea2.approved
    idea2.save

    tag = Tag.new
    tag.name = "tag1"
    tag.save
    tag1 = Tag.new
    tag1.name = "tag2"
    tag1.save
    tag2 = Tag.new
    tag2.name = "tag3"
    tag2.save

    it = IdeasTags.new
    it.idea_id = idea.id
    it.tag_id = tag.id
    it.save
    it1 = IdeasTags.new
    it1.idea_id = idea.id
    it1.tag_id = tag1.id
    it1.save
    it2 = IdeasTags.new
    it2.idea_id = idea1.id
    it2.tag_id = tag1.id
    it2.save
    it3 = IdeasTags.new
    it3.idea_id = idea1.id
    it3.tag_id = tag2.id
    it3.save
    it4 = IdeasTags.new
    it4.idea_id = idea2.id
    it4.tag_id = tag2.id
    it4.save

  end
  describe 'Get #index' do
    it 'populates two ideas matching the search' do
      get :index, :search => "idea2", :tag => [], :mypage => "1", :search_user => "false", :searchtype => "false", 
      :insert => "true", :set_global => "false", :reset_global => "true"
      assigns(:ideas).should eq(1)
    end
  end
end