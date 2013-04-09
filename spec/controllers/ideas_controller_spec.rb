require 'spec_helper'

describe IdeasController do
describe "POST create" do
  include Devise::TestHelpers
  before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        sign_in @user
      end
  context "with valid attributes " do
    it "creates a new idea" do
      expect{
        post :create, idea: Factory.attributes_for(:idea)
      }.to change(Idea,:count).by(1)
    end
    
    it "redirects to the new idea" do
      post :create, idea: Factory.attributes_for(:idea)
      response.should redirect_to Idea.last
    end
  end
  
  context "with invalid attributes" do
    it "does not save the new idea" do
      expect{
        post :create, idea: Factory.attributes_for(:invalid_idea)
      }.to_not change(Idea,:count)
    end
    
    it "re-renders the new method" do
      post :create, idea: Factory.attributes_for(:invalid_idea)
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
    it "located the requested @idea" do
      put :update, id: @idea, idea: Factory.attributes_for(:idea)
      assigns(:idea).should eq(@idea)      
    end
  
    it "changes @idea's attributes" do
      put :update, id: @idea, 
        idea: Factory.attributes_for(:idea)
      @idea.reload
    end
  
    it "redirects to the updated idea" do
      put :update, id: @idea, contact: Factory.attributes_for(:idea)
      response.should redirect_to @idea
    end
  end
  
  context "invalid attributes" do
    it "locates the requested @idea" do
      put :update, id: @idea, idea: Factory.attributes_for(:invalid_idea)
      assigns(:idea).should eq(@idea)      
    end
    
    it "does not change @idea's attributes" do
      put :update, id: @idea, 
        idea: Factory.attributes_for(:idea)
      @idea.reload
    end
    
    it "re-renders the edit method" do
      put :update, id: @edit, edit: Factory.attributes_for(:invalid_idea)
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
    assigns(:idea).should eq(idea)
  end
  
  it "renders the #edit view" do
    get :edit, id: Factory(:idea)
    response.should render_template :edit
  end
end



end