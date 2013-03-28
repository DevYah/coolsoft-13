class TagsController < ApplicationController
 # before_filter :authenticate_user!
  # GET /tags
  # GET /tags.json
  def index
  #  if user_signed_in? and current_user.type.is_a? Admin
    @tags = Tag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
    end
    #else
  # render :text => "You Need To sign in as An Admin"
#  end
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
  #  if user_signed_in? and current_user.type.is_a? Admin
    @tag = Tag.find(params[:id])
    @tags = @tag.tags.all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag }
    end
    #else
    #render :text => "You Need To sign in as An Admin"
   #end
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    #if user_signed_in? and current_user.type.is_a? Admin
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag }
    end
    #else
   #render :text => "You Need To sign in as An Admin"
   #end
  end

  # GET /tags/1/edit
  def edit
  #if user_signed_in? and current_user.type.is_a? Admin
    @tag = Tag.find(params[:id])
    #else
   render :text => "You Need To sign in as An Admin"
   #end
  end

  # POST /tags
  # POST /tags.json
  #Create A new Tag
  #
  # * *Args*    :
  #   - +void+ ->
  # * *Returns* :
  #   - Show#Tag view
  # * *Raises* :
  #   - +PresenceError+ ->If nothing is entered on submit
  #   - +UniquenessError+ -> If Tag added is not unique	
  def create
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
        format.json { render json: @tag, status: :created, location: @tag }
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  # * *Args*    :
  #   - +tag.id+ ->
  # * *Returns* :
  #   - Show#Tag view
  # * *Raises* :
  #   - +PresenceError+ ->If nothing is entered on submit
  #   - +UniquenessError+ -> If new Tag name is not unique	
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    @tag.tags.destroy_all

    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :no_content }
    end
  end
  
  ##
    # Adds a Synonym with the name entered in the form
    #
    # If the entered name does not have an associated tag with the same name
    # a new tag is created with the name and a connection is made
    #
    # Else if the entered name already has a tag but without a connection  
    # a connection is made but a new tag is not created 
    #
    # Else if the entered name already has a tag and a connection to the  
    # parent tag nothing is done and the user is informed so that the 
    # synonym already exists
    #
    #
    # * *Args*    :
    #   - +tag.id+ -> Tag id to add synonyms to
    # * *Returns* :
    #   - The updated Show#Tags/:id view 
    # * *Raises* :
    #   - +SynonymExistsNotice+ -> If Synonym added already exists in @tag.tags
    #
  def addsym
    @tag = Tag.find(params[:id])
    y = params[:tag]['name']
    #query for finding tag with input name returns Tag Array
    tag_query = Tag.where("name = ?", y)  
    respond_to do |format|
      if tag_query.empty?
        t = Tag.new(:name => y)
        t.save
        t.tags << @tag
        @tag.tags << t
        format.html { redirect_to @tag, notice: 'Synonym was successfully created.' }
        format.json { head :no_content }
      elsif not @tag.tags.all.include?(tag_query[0]) and @tag != tag_query[0]
        t = tag_query[0]
        t.tags << @tag
        @tag.tags << t
        format.html { redirect_to @tag, notice: 'Synonym list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @tag, notice: 'Synonym already exits !' }
        format.json { head :no_content }
      end
    end
  end
  
end
