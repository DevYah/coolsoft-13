class IdeasController < ApplicationController
  before_filter :authenticate_user!, :only => [:show, :create, :edit, :update]
  # view idea of current user
  # Params
  # +id+:: is passed in params through the new idea view, it is used to identify the instance of +Idea+ to be viewed
  # Marwa Mehanna
  def show
    @user = current_user.id
    @username = current_user.username
    @idea = Idea.find(params[:id])
    @ideavoted = @current_user.votes.detect { |w|w.id == @idea.id }
    rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
    end
  end

  # making new Idea
  #Marwa Mehanna
  def new
    @idea = Idea.new
    @tags = Tag.all
    @chosentags = []
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea }
    end
  end

  # editing Idea
  # Params
  # +id+ :: this is an instance of +Idea+ passed through _form.html.erb, used to identify which +Idea+ to edit
  # Author: Marwa Mehanna
  def edit
      @idea = Idea.find(params[:id])
      @tags = Tag.all
      @chosentags = Idea.find(params[:id]).tags
    end

  def update
    @idea = Idea.find(params[:id])
    puts(params[:ideas_tags][:tags])
    @idea.tag_ids = params['ideas_tags']['tags'].collect { |t|t.to_i }
    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to @idea, notice: 'Idea was successfully updated' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end 

  # Votes for a specific idea
  # Params:
  # +id+:: is used to specify the instance of +Idea+ to be voted
  # Author: Marwa Mehannna
  def vote
    @idea = Idea.find(params[:id])
    current_user.votes << @idea
    @idea.num_votes = @idea.num_votes + 1
    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to @idea, :notice =>'Thank you for voting' }
        format.json { head :no_content }
      else
        format.html { redirect_to @idea, alert: 'Sorry,cant vote' }
        format.json { head :no_content }
      end
    end
  end

  # UnVotes for a specific idea
  # Params:
  # +id+:: is used to specify the instance of +Idea+ to be unvoted
  # Author: Marwa Mehannna
  def unvote
    @idea = Idea.find(params[:id])
    current_user.votes.delete(@idea)
    @idea.num_votes = @idea.num_votes - 1
    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to @idea, :notice =>'Your vote is deleted' }
        format.json { head :no_content }
      else
        format.html { redirect_to @idea, alert: 'Idea is still voted' }
        format.json { head :no_content }
      end
    end 
  end

  # creating new Idea
  # Params
  # +idea+ :: this is an instance of +Idea+ passed through _form.html.erb, identifying the idea which will be added to records
  # +idea_tags+ :: this is an instance of +IdeaTags+ passed through _form.html.erb, this is where +tags+ will be added
  # +tags+ :: this is an instance of +Tags+ passed through _form.html.erb, used to identify which +Tags+ to add
  # Author: Marwa Mehanna
  def create
    @idea = Idea.new(params[:idea])
    @idea.user_id = current_user.id
    respond_to do |format|
      if @idea.save
        @tags = params[:ideas_tags][:tags]
        @tags.each do |tag|
          IdeasTags.create(:idea_id => @idea.id, :tag_id => tag)
        end
        format.html { redirect_to @idea, notice: 'idea was successfully created.' }
        format.json { render json: @idea, status: :created, location: @idea }
      else
        format.html { render action: 'new' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end
end
