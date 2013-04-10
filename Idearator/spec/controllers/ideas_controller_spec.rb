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
    
    
      
      it "creates a new idea" do
        #attributes = FactoryGirl.attributes_for(:idea)
    #puts @attribues
      #@idea_params = FactoryGirl.attributes_for(:idea)
      #expect { post :create, :idea => @idea_params }.to change(Idea, :count).by(1)
 
        @idea=Idea.new
        @idea.title=@idea.description=@idea.problem_solved="ay7aga"
        @idea.save
        post :create 
        @idea.reload
      end
    end
describe "POST #edit" do
    
    
      
      it "edits an idea" do
 
        @idea1=Idea.new
        @idea1.title=@idea1.description=@idea1.problem_solved="ay7aga"
        @tag1=@idea1.tags.new
        @tag1.name="blah"
        @tag1.save
        @idea1.save
        @idea2=Idea.new
        @idea2.title=@idea2.description=@idea2.problem_solved="this"
        @tag2=@idea2.tags.new
        @tag2.name="blah"
        @tag2.save
        @idea2.save
        @idea1.title=@idea2.title
        @idea1.description=@idea2.description
        @idea1.problem_solved=@idea2.problem_solved
        @tag1=@tag2
        @tag1.save
        @idea1.save

        put :update 
        @idea1.reload
      end
    end

  
end