class CompetitionsController < ApplicationController
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
    @entry = CompetitionEntry.find(:all,:conditions => {:competition_id => @competition.id,:idea_id => @idea.id})
    @entry.first.approved = true
    @entry.first.save
    respond_to do |format|
      format.html { redirect_to  '/competitions/' + @competition.id.to_s + '/review_competitions_ideas' , notice: 'The idea has been approved' }
      format.js
    end
  end

  def reject
    @idea = Idea.find(params[:idea_id])
    @competition = Competition.find(params[:id])
    @entry = CompetitionEntry.find(:all,:conditions => {:competition_id => @competition.id,:idea_id => @idea.id})
    @entry.first.rejected = true
    @entry.first.save
    respond_to do |format|
      format.html { redirect_to  '/competitions/' + @competition.id.to_s + '/review_competitions_ideas' , notice: 'The idea has been approved' }
      format.js
    end
  end
  # GET /competitions/1
  # GET /competitions/1.json
  def show
    @competition = Competition.find(params[:id])
    @chosen_tags_competition = Competition.find(params[:id]).tags
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
end
