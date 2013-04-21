require 'spec_helper'
describe IdeasController do
  describe 'DELETE destroy' do
    include Devise::TestHelpers

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
      sign_in @user
    end

    it 'assigns a new Idea to @idea' do
      @idea = FactoryGirl.create(:idea)
      get :new
      assigns(:idea).should equal(@idea)
    end

    it 'renders the #new view' do
      get :new, :format => 'html'
      response.should render_template 'new'
    end
  end

  describe 'POST #create' do

    it 'creates a new idea' do
      @idea = Idea.new
      @idea.title = @idea.description = @idea.problem_solved = 'ay7aga'
      @idea.save
      post :create, :idea => FactoryGirl.attributes_for(:idea), :idea_tags => { :tags => [] }
      @idea.reload
      Idea.last.should eq(@idea)
    end
  end

  describe 'POST #edit' do

    it 'edits an idea' do
      @idea1 = Idea.new
      @idea1.title = @idea1.description = @idea1.problem_solved = 'ay7aga'
      @tag1 = @idea1.tags.new
      @tag1.name = 'blah'
      @tag1.save
      @idea1.save
      put :update, :id => @idea1.id, :idea => { :title => 'ay title' }
      @idea1.reload
      @idea1.title.should eq('ay title')
    end
  end

  context 'user wants to vote' do
    before :each do
      @user = FactoryGirl.build(:user)
      @user.confirm!
      @idea = FactoryGirl.create(:idea)
      @idea.user_id = @user.id
      @idea.save
      sign_in @user
    end

    it 'idea id in user.votes' do
      put :vote, :id => @idea.id
      @idea.reload
      @voted = @user.votes.find(@idea)
      (@voted.id).should eql(@idea.id)
    end

    it 'redirects to idea' do
      put :vote, :id => @idea.id
      response.should redirect_to @idea
    end

    it 'increase idea votes' do
      @numvotes = @idea.num_votes + 1
      put :vote, :id => @idea.id
      @idea.reload
      (@numvotes).should eql(@idea.num_votes)
    end
  end

  context 'user wants to unvote' do
    before :each do
      @user = FactoryGirl.build(:user)
      @user.confirm!
      @idea = FactoryGirl.create(:idea)
      @idea.user_id = @user.id
      @idea.save
      sign_in @user
    end

    it 'idea id deleted from user.votes' do
      put :unvote, :id => @idea.id
      @idea.reload
      @voted = @user.votes.find(:first, :conditions => {id: @idea_id})
      (@voted).should eql(nil)
    end

    it 'redirects to idea' do
      put :unvote, :id => @idea.id
      response.should redirect_to @idea
    end

    it 'increase idea votes' do
      @numvotes = @idea.num_votes - 1
      put :unvote, :id => @idea.id
      @idea.reload
      (@numvotes).should eql(@idea.num_votes)
    end
  end

  context 'idea creator wants to archive' do
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

    it 'archives the idea' do
      put :archive, :id => @idea.id
      @idea.reload
      (@idea.archive_status).should eql(true)
    end

    it 'redirects to idea' do
      put :archive, :id => @idea.id
      response.should redirect_to @idea
    end

    it 'deletes idea comments' do
      expect { put :archive, :id => @idea.id }.to change(Comment, :count).by(-1)
    end

    it 'deletes idea votes' do
      expect { put :archive, :id => @idea.id }.to change(Vote, :count).by(-1)
    end
  end

  context 'admin wants to archive' do
    before :each do
      @admin = FactoryGirl.build(:admin)
      @admin.confirm!
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
      sign_in @admin
    end

    it 'archives the idea' do
      put :archive, :id => @idea.id
      @idea.reload
      (@idea.archive_status).should eql(true)
    end

    it 'redirects to idea' do
      put :archive, :id => @idea.id
      response.should redirect_to @idea
    end

    it 'deletes idea comments' do
      expect { put :archive, :id => @idea.id }.to change(Comment, :count).by(-1)
    end

    it 'deletes idea votes' do
      expect { put :archive, :id => @idea.id }.to change(Vote, :count).by(-1)
    end
  end


  context 'normal user wants to archive' do
    before :each do
      @user = FactoryGirl.build(:user)
      @user.confirm!
      @idea = FactoryGirl.create(:idea)
      sign_in @user
    end

    it 'does not archive the idea' do
      @arch_stat = @idea.archive_status
      put :archive, :id => @idea.id
      @idea.reload
      (@idea.archive_status).should eql(@arch_stat)
    end

    it 'redirects to idea' do
      put :archive, :id => @idea.id
      response.should redirect_to @idea
    end

    it 'does not delete idea votes' do
      expect { put :archive, :id => @idea.id }.to change(Vote, :count).by(0)
    end

    it 'does not delete idea comments' do
      expect { put :archive, :id => @idea.id }.to change(Comment, :count).by(0)
    end
  end

  context 'idea creator wants to unarchive' do
    before :each do
      @user = FactoryGirl.build(:user)
      @user.confirm!
      @idea = FactoryGirl.create(:idea)
      @idea.user_id = @user.id
      @idea.save
      sign_in @user
    end

    it 'unarchives the idea' do
      put :unarchive, :id => @idea.id
      @idea.reload
      (@idea.attributes['archive_status']).should eql(false)
    end

    it 'redirects to idea' do
      put :unarchive, :id => @idea.id
      response.should redirect_to @idea
    end
  end

  context 'admin wants to unarchive' do
    before :each do
      @admin = FactoryGirl.build(:admin)
      @admin.confirm!
      @idea = FactoryGirl.create(:idea)
      sign_in @admin
    end

    it 'unarchives the idea' do
      put :unarchive, :id => @idea.id
      @idea.reload
      (@idea.archive_status).should eql(false)
    end

    it 'redirects to idea' do
      put :unarchive, :id => @idea.id
      response.should redirect_to @idea
    end
  end

  context 'normal user wants to unarchive' do
    before :each do
      @user = FactoryGirl.build(:user)
      @user.confirm!
      @idea = FactoryGirl.create(:idea)
      sign_in @user
    end

    it 'does not unarchive the idea' do
      @arch_stat = @idea.archive_status
      put :unarchive, :id => @idea.id
      @idea.reload
      (@idea.archive_status).should eql(@arch_stat)
    end

    it 'redirects to idea' do
      put :unarchive, :id => @idea.id
      response.should redirect_to @idea
    end
  end
end
