require 'spec_helper'
describe IdeasController do
  include Devise::TestHelpers
  describe "GET #show" do
    before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        @idea.user_id = @user.id
        @idea.save
        sign_in @user
      end
    it "assigns the requested idea to @idea" do
      #idea = Factory(:idea)
      get :show, :id => @idea.id
      assigns(:idea).should eq(@idea)
    end
    it "renders the #show view" do
    get :show, id: FactoryGirl.attributes_for(:idea)
    response.should render_template :show
  end

  end
  describe "GET #new" do
    before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        #@idea = FactoryGirl.create(:idea)
        #@idea.user_id = @user.id
        #@idea.save
        sign_in @user
      end
    it "assigns a new Idea to @idea" do
     @idea = FactoryGirl.create(:idea)
      get :new
      end
    it "renders the #new view" do
      get :new, :format => "html"
      #response.should render_template :new
    end
  end
 describe "POST #create" do
    before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.build(:idea)
        @idea.user_id = @user.id
        @idea.save
        sign_in @user
      end
    context "with valid attributes" do
      it "creates a new idea" do
        attributes = FactoryGirl.attributes_for(:idea)
    puts @attribues
        expect{
          post :create, idea:  FactoryGirl.attributes_for(:idea)
        }.to change(Idea,:count).by(1)
      end
      it "redirects to the new contact" do
        post :create, idea: FactoryGirl.attributes_for(:idea)
        response.should redirect_to Idea.last
      end
    end
    context "with invalid attributes" do
      it "does not save the new idea in the database" do
        expect{
          post :create, idea: FactoryGirl.attributes_for(:invalid_idea)
        }.to_not change(Idea,:count)
      end
      it "re-renders the new method" do
        post :create, idea: FactoryGirl.attributes_for(:invalid_idea)
        response.should render_template :new
      end
    end
  end
end