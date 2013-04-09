require 'spec_helper'
describe CommentsController do
describe "POST create" do
  include Devise::TestHelpers
  before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        sign_in @user
      end
  context "with valid attributes " do
    it "creates a new comment" do
      expect{
        post :create, idea: Factory.attributes_for(:comment)
      }.to change(Comment,:count).by(1)
    end
    
    it "redirects to the new Comment" do
      post :create, comment: Factory.attributes_for(:comment)
      response.should redirect_to Comment.last
    end
  end
  
  context "with invalid attributes" do
    it "does not save the new comment" do
      expect{
        post :create, comment: Factory.attributes_for(:invalid_comment)
      }.to_not change(Comment,:count)
    end
    
    it "re-renders the new method" do
      post :create, comment: Factory.attributes_for(:invalid_comment)
      response.should render_template :new
    end
  end 
end


describe 'PUT update' do
   before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        @idea.user_id = @user.id
        @idea.save
        sign_in @user
      end
  
  context "valid attributes" do
    it "located the requested @comment" do
      put :update, id: @comment, comment: Factory.attributes_for(:comment)
      assigns(:comment).should eq(@comment)      
    end
  
    it "changes @idea's attributes" do
      put :update, id: @comment, 
        comment: Factory.attributes_for(:comment)
      @comment.reload
    end
  
    it "redirects to the updated comment" do
      put :update, id: @comment, contact: Factory.attributes_for(:comment)
      response.should redirect_to @comment
    end
  end
  
  context "invalid attributes" do
    it "locates the requested @comment" do
      put :update, id: @comment, comment: Factory.attributes_for(:invalid_comment)
      assigns(:comment).should eq(@comment)      
    end
    
    it "does not change @comment's attributes" do
      put :update, id: @comment, 
        idea: Factory.attributes_for(:comment)
      @idea.reload
    end
    
    it "re-renders the edit method" do
      put :update, id: @edit, edit: Factory.attributes_for(:invalid_comment)
      response.should render_template :edit
    end
  end
end

describe "GET #show" do
  it "assigns the requested idea to @idea" do
    idea = Factory(:id)
    get :show, id: idea
    assigns(:idea).should eq(idea)
  end
  
  it "renders the #show view" do
    get :show, id: Factory(:idea)
    response.should render_template :show
  end
end
describe "GET #edit" do
  it "assigns the requested idea to @idea" do
    idea = Factory(:id)
    get :edit, id: idea
    assigns(:comment).should eq(comment)
  end
  
  it "renders the #edit view" do
    get :edit, id: Factory(:idea)
    response.should render_template :edit
  end
end



end
