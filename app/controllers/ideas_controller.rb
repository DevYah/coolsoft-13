class IdeasController < ApplicationController
  before_filter :authenticate_user!, :only => [:show, :create ,:edit]
  # view idea of current user
   #+id+:: is passed in params through the new idea view, it is used to identify the instance of +Idea+
  #Marwa Mehanna
  def show
    @user=current_user.id
    @idea = Idea.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
    end
  end
  def index
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
  #Params
    #+id+ :: his is an instance of Idea passed through _form.html.erb +Idea+
  #Marwa Mehanna
  def edit   
    @idea = Idea.find(params[:id])
    @tags= Tag.all
    @chosentags= Idea.find(params[:id]).tags
  end
  # updating Idea
  #Params
    #+ideas_tags:: this is an instance of Idea passed through _form.html.erb +IdeaTags+ 
    #+id+ ::his is an instance of Idea passed through _form.html.erb +Idea+
  #Marwa Mehanna
  def update
    puts(params[:ideas_tags][:tags])
    @idea = Idea.find(params[:id])
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
  #Params
    #+idea+ :: this is an instance of Idea passed through _form.html.erb +IdeaTable+
    #+idea_tags+ :: this is an instance of Idea passed through _form.html.erb+IdeasTags+
    #+tags+ ::this is an instance of Tag passed through _form.html.erb +Tags+
  #Marwa Mehanna
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
end
