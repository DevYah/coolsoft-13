require 'spec_helper'
describe CommentsController do
describe "POST create" do
  include Devise::TestHelpers
 
  context "with valid attributes " do
    it "creates a new comment" do
      i = Idea.new 
      i.title = "dayna"
      i.description = "description"
      i.problem_solved = "problem"
      i.save
      expect{
        post :create, :idea_id => i.id , :comment => { :content => "comment"}
      }.to change(Comment,:count).by(1)
    end
    
   
  end

end


describe 'PUT update' do
  
    it "changes @comment's attributes" do
      @idea = Idea.new 
      @idea.title=@idea.description=@idea.problem_solved="Daynaaaaaaa"
      @comment = Comment.new
      @comment.content="Daynaaaa Again"
      @comment.idea_id = @idea.id
      @idea.save
      @comment.save
      put :update,:id => @comment.id, :idea_id => @idea.id , :comment => { :content => "dayna "}
      @idea.reload
      @comment.reload
      @comment.content.should eq("dayna ")
    end
  end

describe "GET #edit" do
  it "renders the #edit view" do
    idea = Idea.new
    idea.title= idea.description = idea.problem_solved = "dayna"
    idea.save
    comment = Comment.new
    comment.content = 'dayna'
    comment.save
    get :edit, :idea_id  => idea.id , :id => comment.id
    response.should render_template :edit
  end
end



end
