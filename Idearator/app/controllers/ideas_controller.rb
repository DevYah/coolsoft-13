class IdeasController < ApplicationController

  before_filter :authenticate_user!, :only => [:create , :edit, :update ,:like ,:vote ,:unvote]

  # view idea of current user
  # Params
  # +id+:: is passed in params through the new idea view, it is used to identify the instance of +Idea+ to be viewed
  # Marwa Mehanna
  def show
    @idea = Idea.find(params[:id])
    if user_signed_in?
      @user = current_user.id
      @username = current_user.username
      @tags = Tag.all
      @chosentags = Idea.find(params[:id]).tags
      @ideavoted = current_user.votes.detect { |w|w.id == @idea.id } rescue ActiveRecord::RecordNotFound

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @idea }
      end
    end
  end

  # making new Idea
  #Marwa Mehanna
  def new
    puts 'hashish first print'
    @idea = Idea.new
    puts 'hashish    ' + @idea.to_s + ' hashish'
    @tags = Tag.all
    @chosentags = []
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea }
    end
  end

  # filters the ideas that have one or more of given tags
  # Params:
  # +tags:: the parameter is an list of +Tag+ passed through tag autocomplete field
  # Author: muhammed hassan
  def filter
    @approved = Idea.joins(:tags).where(:tags => {:name => params[:myTags]}).uniq.page(params[:page]).per(10)
    @tags = params[:myTags]
    respond_to do |format|
      format.js
      format.json  { render :json => @approved }
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
    @boolean = true
  end

  # updating Idea
  # Params
  # +ideas_tags:: this is an instance of +IdeasTag+ passed through _form.html.erb, this is where +tags+ will be added
  # +tags+ :: this is an instance of +Tags+ passed through _form.html.erb, used to identify which +Tags+ to add
  # Author: Marwa Mehanna
  def update
    @idea = Idea.find(params[:id])
    @ideavoters = @idea.votes
    @userVreceivers = []
    if !@idea.votes.nil?
      @ideavoters.each { |user|
        if user.participated_idea_notifications
          @userVreceivers << user
      end }
      EditNotification.send_notification(current_user, @idea, @userVreceivers)
    end
    list_of_comments = Comment.where(idea_id: @idea.id)
    list_of_commenters = []
    list_of_comments.each do |c|
      list_of_commenters.append(User.find(c.user_id)).flatten!
    end
    list = list_of_commenters
    if list != nil
      EditNotification.send_notification(current_user, @idea, list)
    end
    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to @idea, :notice => 'Idea was successfully updated.' }
        format.json { respond_with_bip(@idea) }
      else
        format.html { render :action => 'edit' }
        format.json { respond_with_bip(@idea) }
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
    @ideaowner = User.find(@idea.user_id)
    if @ideaowner.own_idea_notifications
      VoteNotification.send_notification(current_user, @idea, [@ideaowner])
    end
    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to @idea, :notice =>'Thank you for voting' }
        format.json { head :no_content }
        format.js
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
        format.js
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
        VoteCount.create(idea_id: @idea.id)
        format.html { redirect_to @idea, notice: 'idea was successfully created.' }
        format.json { render json: @idea, status: :created, location: @idea }
      else
        format.html { render action: 'new' }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # Deletes all records related to a specific idea
  # Params:
  # +id+:: is used to specify the instance of +Idea+ to be archived
  # Author: Mahmoud Abdelghany Hashish
  def destroy
    idea = Idea.find(params[:id])
    if current_user.id == idea.user_id
      list_of_comments = Comment.where(idea_id: idea.id)
      list_of_commenters = []
      list_of_voters = idea.votes

      list_of_comments.each do |c|
        list_of_commenters.append(User.find(c.user_id)).flatten!
        c.destroy
      end

      list = list_of_commenters.append(list_of_voters).flatten!

      DeleteNotification.send_notification(current_user, idea, list)

      idea.destroy

      respond_to do |format|
        format.html { redirect_to '/', alert: 'Your Idea has been successfully deleted!' }
      end
    else
      respond_to do |format|
        format.html { redirect_to idea, alert: 'You do not own the idea, so it cannot be deleted!' }
      end
    end
  end

  # Archives a specific idea
  # Params:
  # +id+:: is used to specify the instance of +Idea+ to be archived
  # Author: Mahmoud Abdelghany Hashish
  def archive
    idea = Idea.find(params[:id])

    if current_user.type == 'Admin' || current_user.id == idea.user_id
      idea.archive_status = true
      idea.save
      list_of_commenters = []
      idea.comments.each do |c|
        list_of_commenters.append(User.find(c.user_id)).flatten!
      end
      list = list_of_commenters.append(idea.votes).flatten!

      if current_user.type == 'Admin'
        list.append(User.find(idea.user_id)).flatten!
      end

      ArchiveNotification.send_notification(current_user, idea, list)
      idea.votes.each do |u|
        idea.votes.delete(u)
      end

      idea.num_votes = 0

      idea.comments.each do |c|
        c.destroy
      end

      list_of_ratings = Rating.where(:idea_id => idea.id)
      list_of_user_ratings = []

      list_of_ratings.each do |r|
        list_of_user_ratings.append(UserRating.where(:rating_id => r.id)).flatten!
      end

      list_of_user_ratings.each do |ur|
        ur.destroy
      end

      idea.save

      respond_to do |format|
        format.html { redirect_to idea, alert: 'Idea has been successfully archived!' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to idea, alert: "Idea isn't archived, you are not allowed to archive it." }
        format.js { head :no_content }
      end
    end
  end

  # Unarchives a specific idea
  # Params:
  # +id+:: is used to specify the instance of +Idea+ to be unarchived
  # Author: Mahmoud Abdelghany Hashish
  def unarchive
    idea = Idea.find(params[:id])
    if current_user.type == 'Admin' || current_user.id == idea.user_id
      idea.archive_status = false
      idea.save
    else
      respond_to do |format|
        format.html { redirect_to idea, alert: "Idea isn't archived, you are not allowed to archive it." }
        format.js { head :no_content }
      end
    end
  end

  #adds the rating prespectives taken from the user from the add_prespectives view
  #to the idea reviewed
  # Params
  #+params[:ratings]+ ratings prespectives taken from the user
  #+session[:idea_id] id of the idea to be reviewed
  #Author : Omar Kassem
  def add_rating
    if current_user.type == 'Committee'
      @idea=Idea.find(params[:id])
      @idea.approved = true
      @idea.save
      @rating = params[:rating]
      @rating.each do |rate|
        r = Rating.find(:all, :conditions => {:name => rate})
        @idea.ratings << r
        @idea.save
      end
      respond_to do |format|
        format.js {render "add_rating"}
      end
    else
      respond_to do |format|
        format.html { redirect_to  '/' , notice: 'You cant add rating prespectives' }
        format.json { head :no_content }
      end
    end
  end

  def enroll_idea

  end
end
