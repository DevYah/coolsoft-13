require 'spec_helper'
describe IdeasController do
      include Devise::TestHelpers

   it 'show ' do
        @user = User.new
        @user.email = "119ggpkkkkkq@gmail.com"
        @user.confirm!
        @user.save
        idea = Idea.new
        idea.title = idea.description = idea.problem_solved = "Dayna"
        idea.save
        @comment = Comment.new
        @comment.content = "dayna" 
        @comment.idea_id = idea.id
        @comment.num_likes = 0
        @comment.save
         @like = Like.new
         @like.user_id = @user.id
        @like.comment_id = @comment.id
        @like.save
        sign_in @user
        get :like , :id => idea.id , :commentid => @comment.id
        @comment.reload
        @comment.num_likes.should eq(1)
    end
 

    context 'idea creator wants to delete' do
      before :each do
        @user = FactoryGirl.build(:user)
        @user.confirm!
        @idea = FactoryGirl.create(:idea)
        @idea.user_id = @user.id
        @idea.save
        @comment = FactoryGirl.build(:comment)
        @comment.user_id = @user.id
        @comment.idea_id = @idea.id
        @comment.save
        @vote = FactoryGirl.build(:vote)
        @vote.user_id = @user.id
        @vote.idea_id = @idea.id
        @vote.save
        sign_in @user
      end

      it 'deletes the idea' do
        expect { delete :destroy, :id => @idea.id }.to change(Idea, :count).by(-1)
      end

      it 'redirects to home' do
        delete :destroy, :id => @idea.id
        response.should redirect_to '/'
      end

      it 'deletes idea comments' do
        expect { delete :destroy, :id => @idea.id }.to change(Comment, :count).by(-1)
      end

      it 'deletes idea votes' do
        expect { delete :destroy, :id => @idea.id }.to change(Vote, :count).by(-1)
      end
       it 'likes a comment ' do
        @user = User.new
        @user.email = "119ggpkkkkkq@gmail.com"
        @user.confirm!
        @user.save
        idea = Idea.new
        idea.title = idea.description = idea.problem_solved = "Dayna"
        idea.save
        @comment = Comment.new
        @comment.content = "dayna" 
        @comment.idea_id = idea.id
        @comment.num_likes = 0
        @comment.save
         @like = Like.new
         @like.user_id = @user.id
        @like.comment_id = @comment.id
        @like.save
        sign_in @user
        get :like , :id => idea.id , :commentid => @comment.id
        @comment.reload
        @comment.num_likes.should eq(1)

   end

    end

    context 'normal user wants to delete idea' do
      before :each do
        @userone = FactoryGirl.build(:user)
        @userone.confirm!
        @usertwo = FactoryGirl.build(:user_two)
        @usertwo.confirm!
        @idea = FactoryGirl.create(:idea)
        @idea.user_id = @userone.id
        @idea.save
        @comment = FactoryGirl.build(:comment)
        @comment.user_id = @userone.id
        @comment.idea_id = @idea.id
        @comment.save
        @vote = FactoryGirl.build(:vote)
        @vote.user_id = @userone.id
        @vote.idea_id = @idea.id
        @vote.save
        sign_in @usertwo
      end

      it 'does not delete the idea' do
        expect { delete :destroy, :id => @idea.id }.to change(Idea, :count).by(0)
      end

      it 'redirects to idea' do
        delete :destroy, :id => @idea.id
        response.should redirect_to @idea
      end

      it 'does not delete idea comments' do
        expect { delete :destroy, :id => @idea.id }.to change(Comment, :count).by(0)
      end

      it 'does not delete idea votes' do
        expect { delete :destroy, :id => @idea.id }.to change(Vote, :count).by(0)
      end
    end
  end

  describe 'GET #show' do
    before :each do
      @user = FactoryGirl.build(:user)
      @user.confirm!
      @idea = FactoryGirl.create(:idea)
      @idea.user_id = @user.id
      @idea.save
      sign_in @user
    end
    it 'assigns the requested idea to @idea' do
      #idea = Factory(:idea)
      get :show, :id => @idea.id
      assigns(:idea).should eq(@idea)
    end

    it 'renders the #show view' do
      get :show, id: FactoryGirl.attributes_for(:idea)
      response.should render_template :show
    end
  end

  describe 'GET #new' do
    before :each do
      @user = FactoryGirl.build(:user)
      @user.confirm!
      #@idea = FactoryGirl.create(:idea)
      #@idea.user_id = @user.id
      #@idea.save
      sign_in @user
    end

    it 'assigns a new Idea to @idea' do
      @idea = FactoryGirl.create(:idea)
      get :new
    end

    it 'renders the #new view' do
      get :new, :format => 'html'
      #response.should render_template :new
    end
  end

  describe 'POST #create' do
    before :each do
      @user = FactoryGirl.build(:user)
      @user.confirm!
      @idea = FactoryGirl.build(:idea)
      @idea.user_id = @user.id
      @idea.save
      sign_in @user
    end

    context 'with valid attributes' do
      it 'creates a new idea' do
        attributes = FactoryGirl.attributes_for(:idea)
        puts @attribues
        expect {
          post :create, idea: FactoryGirl.attributes_for(:idea)
        }.to change(Idea, :count).by(1)
      end

      it 'redirects to the new contact' do
        post :create, idea: FactoryGirl.attributes_for(:idea)
        response.should redirect_to Idea.last
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new idea in the database' do
        expect {
          post :create, idea: FactoryGirl.attributes_for(:invalid_idea)
        }.to_not change(Idea, :count)
      end

      it 're-renders the new method' do
        post :create, idea: FactoryGirl.attributes_for(:invalid_idea)
        response.should render_template :new
      end
    end
  end
end
