class IdeasController < ApplicationController
  before_filter :authenticate_user!, :only => [:show, :create ,:edit, :update]
  # view idea of current user
  # Params
  # +id+:: is passed in params through the new idea view, it is used to identify the instance of +Idea+ to be viewed
  # Marwa Mehanna
  def show
    @user=current_user.id
    @idea = Idea.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
    end
  end
  # making new Idea
  #Marwa Mehanna
  def new
    @idea=Idea.new
    @tags= Tag.all
    @chosentags=[]
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
    @tags= Tag.all
    @chosentags= Idea.find(params[:id]).tags
  end
  # updating Idea
  # Params
  # +ideas_tags:: this is an instance of +IdeasTag+ passed through _form.html.erb, this is where +tags+ will be added
  # +tags+ :: this is an instance of +Tags+ passed through _form.html.erb, used to identify which +Tags+ to add
  # Author: Marwa Mehanna
  def update
    @idea = Idea.find(params[:id])
    puts(params[:ideas_tags][:tags])
    @idea.tag_ids=params["ideas_tags"]["tags"].collect{|t|t.to_i}
    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
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
    @idea.user_id=current_user.id
    respond_to do |format|
      if @idea.save
        @tags= params[:ideas_tags][:tags]
        @tags.each do |tag|
          IdeasTags.create(:idea_id => @idea.id , :tag_id => tag)
        end
        format.html { redirect_to @idea, notice: 'idea was successfully created.' }
        format.json { render json: @idea, status: :created, location: @idea }
      else
        format.html { render action: "new" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end
  # Archives a specific idea
  # Params:
  # +id+:: is used to specify the instance of +Idea+ to be archived
  # Author: Mahmoud Abdelghany Hashish
  def archive
    @idea = Idea.find(params[:id])
    
    if current_user.type == 'Admin' || current_user.id == @idea.user_id
      @idea.archive_status = true
      @idea.save

      respond_to do |format|
        format.html { redirect_to @idea, alert: 'Idea has been successfully archived.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @idea, alert: "Idea isn't archived, you are not allowed to archive it." }
        format.json { head :no_content }
      end
    end
  end
  # Unarchives a specific idea
  # Params:
  # +id+:: is used to specify the instance of +Idea+ to be unarchived
  # Author: Mahmoud Abdelghany Hashish    
  def unarchive
    @idea = Idea.find(params[:id])

    if current_user.type == 'Admin' || current_user.id == @idea.user_id
      @idea.archive_status = false
      @idea.save
        
      respond_to do |format|
        format.html { redirect_to @idea, alert: 'Idea has been successfully unarchived.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @idea, alert: "Idea isn't archived, you are not allowed to archive it." }
        format.json { head :no_content }
      end
    end
  end   
  # Deletes all records related to a specific idea
  # Params:
  # +id+:: is used to specify which instance of +Idea+ will be deleted
  # Author: Mahmoud Abdelghany Hashish
  def destroy
    @idea = Idea.find(params[:id])

    if current_user.id == @idea.user_id
      @idea.destroy

      respond_to do |format|
        format.html { redirect_to '/', alert: 'Idea is successfully deleted.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @idea, alert: "Deleting failed, you don't own the idea." }
        format.json { head :no_content }
      end
    end
  end
end