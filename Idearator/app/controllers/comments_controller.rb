class CommentsController < ApplicationController
#Show all Comments 
#author dayna
def show
   @idea = Idea.find(params[:id])
   respond_to do |format|
     format.html # show.html.erb
     format.xml  { render :xml => @comment }
   end
end
def new
   @comment = Comment.new
   respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
   end
end
#create new Comment by building comments after getting the id of the idea 
#author dayna 
def create
   @idea = Idea.find(params[:idea_id])
    @comment = @idea.comments.create(params[:comment])
    @comment.update_attributes(:idea_id => @idea.id)
    respond_to do |format|
      if @comment.save
       format.html { redirect_to(@idea, :notice => 'Comment was successfully created.') }
       format.xml  { render :xml => @idea, :status => :created, :location => @idea }
      else
       format.html { redirect_to(@idea, :notice => 
        'Comment could not be saved. Please fill in all fields')}
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
   redirect_to comment_path(@idea)
end
#edit comment by checking the comment's id and modifying it
#author dayna
def edit
    @comment = Comment.find(params[:id])
    @idea = Idea.find(params[:idea_id])
end
def update
    @comment = Comment.find(params[:id])
    @idea = Idea.find(params[:idea_id])
     respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@idea, :notice => 'Comment was successfully updated.') }
        format.xml  { head :no_content }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end
end
