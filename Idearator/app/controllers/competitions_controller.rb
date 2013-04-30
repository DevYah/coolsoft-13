class CompetitionsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new ,:create , :edit, :update]
  # GET /competitions
  # GET /competitions.json
  def index
    @competitions = Competition.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @competitions }
    end
  end


  def review_competitions_ideas
    @competition = Competition.find(params[:id])
    if current_user != nil && current_user.id == @competition.investor_id
      @ideas = CompetitionEntry.find(:all,:conditions =>{:approved => false, :rejected => false, :competition_id => @competition.id})
      @ideas.map!{|id| Idea.find(id)}
    else
      respond_to do |format|
        format.html { redirect_to  '/' , notice: 'You can not review ideas' }
        format.json { head :no_content }
      end
    end
  end

  def approve

    @idea = Idea.find(params[:idea_id])
    @competition = Competition.find(params[:id])
    if current_user != nil && current_user.id == @competition.investor_id
      @entry = CompetitionEntry.find(:all,:conditions => {:competition_id => @competition.id,:idea_id => @idea.id})
      @entry.first.approved = true
      @entry.first.save
      respond_to do |format|
        format.html { redirect_to  '/competitions/' + @competition.id.to_s + '/review_competitions_ideas' , notice: 'The idea has been approved' }
        format.js
      end

    else
      respond_to do |format|
        format.html { redirect_to  '/' , notice: 'You can not approve ideas' }
        format.json { head :no_content }
      end
    end
  end
  def reject
    @idea = Idea.find(params[:idea_id])
    @competition = Competition.find(params[:id])
    if current_user != nil && current_user.id == @competition.investor_id
      @entry = CompetitionEntry.find(:all,:conditions => {:competition_id => @competition.id,:idea_id => @idea.id})
      @entry.first.rejected = true
      @entry.first.save
      respond_to do |format|
        format.html { redirect_to  '/competitions/' + @competition.id.to_s + '/review_competitions_ideas' , notice: 'The idea has been approved' }
        format.js
      end

    else
      respond_to do |format|
        format.html { redirect_to  '/' , notice: 'You can not reject ideas' }
        format.json { head :no_content }
      end
    end
  end

  # view competition of current user
  # Params
  # +id+:: is passed in params through the new competition view, it is used to identify the instance of +Competition+ to be viewed
  # Marwa Mehanna
  def show
    @competition = Competition.find(params[:id])
    @chosen_tags_competition = Competition.find(params[:id]).tags
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @competition }
    end
  end

  # making new Competition
  #Marwa Mehann
  def new
    @competition = Competition.new
    chosen_tags_competition=[]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @competition }
    end
  end

  ## editing Idea
  # Params
  # +id+ :: this is an instance of +Competition+ passed through _form.html.erb, used to identify which +Competition+ to edit
  # Author: Marwa Mehanna
  def edit
    @competition = Competition.find(params[:id])
    @chosen_tags_competition = Competition.find(params[:id]).tags
  end

  # creating new Idea
  # Params
  # +competition+ :: this is an instance of +Competition+ passed through _form.html.erb, identifying the competition which will be added to records
  # Author: Marwa Mehanna
  def create
    @competition = Competition.new(params[:competition])
    @competition.investor_id = current_user.id
    respond_to do |format|
      if @competition.save
        format.html { redirect_to @competition, notice: 'Competition was successfully created.' }
        format.json { render json: @competition, status: :created, location: @competition }
      else
        format.html { render action: "new" }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # updating Idea
  # Params
  # +id+ :: this is an instance of +Competition+ passed through _form.html.erb, used to identify which +Competition+ to edit
  # Author: Marwa Mehanna
  def update
    @competition = Competition.find(params[:id])

    respond_to do |format|
      if @competition.update_attributes(params[:competition])
        format.html { redirect_to @competition, :notice => 'Competition was successfully updated.' }
        format.json { respond_with_bip(@competition) }
      else
        format.html { render :action => 'edit' }
        format.json { respond_with_bip(@competition) }
      end
    end
  end

  # Deletes all records related to a specific idea
  # Params:
  # +id+:: is used to specify the instance of +competition+ to be deleted
  #Author: Marwa Mehanna
  def destroy
    @competition = Competition.find(params[:id])
    if current_user.id == @competition.investor_id
      @competition.destroy
      respond_to do |format|
        format.html { redirect_to '/', alert: 'Your Competition has been successfully deleted!' }
      end

    else
      respond_to do |format|
        format.html { redirect_to idea, alert: 'You do not own the idea, so it cannot be deleted!' }
      end
    end
  end
end
