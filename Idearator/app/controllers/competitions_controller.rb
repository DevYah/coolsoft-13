class CompetitionsController < ApplicationController
  # GET /competitions
  # GET /competitions.json
  def index
    @competitions = Competition.all

    respond_to do |format|
      format.js
    end
  end

  # GET /competitions/1
  # GET /competitions/1.json
  def show
    @competition = Competition.find(params[:id])
    @chosen_tags_competition = Competition.find(params[:id]).tags
    @myIdeas=User.find(current_user).ideas.find(:all, :conditions =>{:approved => true, :rejected => false})
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @competition }
    end
  end

  # GET /competitions/new
  # GET /competitions/new.json
  def new
    @competition = Competition.new
    chosen_tags_competition=[]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @competition }
    end
  end

  # GET /competitions/1/edit
  def edit
    @competition = Competition.find(params[:id])
    @chosen_tags_competition = Competition.find(params[:id]).tags
  end

  # POST /competitions
  # POST /competitions.json
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

  # PUT /competitions/1
  # PUT /competitions/1.json
  def update
    @competition = Competition.find(params[:id])

    respond_to do |format|
      if @competition.update_attributes(params[:competition])
        format.html { redirect_to @competition, notice: 'Competition was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competitions/1
  # DELETE /competitions/1.json
  def destroy
    @competition = Competition.find(params[:id])
    @competition.destroy

    respond_to do |format|
      format.html { redirect_to competitions_url }
      format.json { head :no_content }
    end
  end

  # Enrolls a chosen Idea into a competition
  # Params:
  # +id+:: the parameter is an instance of +Idea+ passed through the enroll_idea partial view
  # +id1+:: the parameter is an instance of +Competition+ passed through the enroll_idea partial view
  # Author: Mohammad Abdulkhaliq
  def enroll_idea
    @idea = Idea.find(params[:id])
    @competition = Competition.find(params[:id1])
    if not @idea.competitions.where(:id => @competition.id).exists?
      @competition.ideas << @idea
      EnterIdeaNotification.send_notification(@idea.user, @idea, @competition, [@competition.investor])
      respond_to do |format|
        format.html { redirect_to @competition, notice: 'Idea Submitted successfully'}
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @competition, notice: 'This idea is already enrolled in this competiton'}
        format.json { head :no_content }
      end
    end
  end
end
