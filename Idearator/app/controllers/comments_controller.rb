class CommentsController < ApplicationController
#Show all Comments
#Params:
#+idea_id+ :: the parameter is an instance of +Idea+
#passed through the form of action create
#author dayna

def show
   @idea = Idea.find(params[:id])
   respond_to do |format|
     format.html # show.html.erb
     format.xml  { render :xml => @comment }
   end
end
#create new Comment
#Params:
#+idea_id+ :: the parameter is an instance
#of +Idea+ passed to get the id of the idea to build the comments
#+comment_id+ :: the parameter is an instance
# of +Comment+ and it's used to show the comments after posting it
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
       format.html { redirect_to(@idea, :notice => 'Comment could not be saved. Please fill in all fields') }
        format.xml { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
end
#edit comment and update it
#Params:
#+comment_id+ :: the parameter is an instance of +Comment+
#to get the comment's id in order to modify it
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
        format.html { render :action => 'edit' }
        format.xml  { render :xml => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end
#delete comment
#Params:
#+comment_id+ :: the parameter is an instance
#of +Comment+ to get the comment's id in order to delete it
#+idea_id+ :: the parameter is an instance of
# +Idea+ to get the idea's id in order to modify it after deleting the comment
#author dayna

def destroy
    @idea = Idea.find(params[:idea_id])
    @comment = @idea.comments.find(params[:id])
    @comment.destroy
    redirect_to idea_path(@idea)
end
/def like
 # @current_user =  User.find(params[:id])
  @current_user =  User.first
  @idea = Idea.find(params[:idea_id])
  @comment = @idea.comments.find(params[:id])
  @commentsLiked = Like.find(params[:user_id]).comment_id
  #if Like.find(params[:comment_id]) == @comment
  && Like.find(params[:user_id]) == @current_user
#else
  if @commentsLiked =! @comment
  @comment.num_likes+=1
  # @comment.num_likes + 1
  @like = @comment.num_likes
  @like.save
   #    format.html { redirect_to(@idea, :notice => 'like was successfully created.') }
    #   format.xml  { render :xml => @idea, :status => :created, :location => @idea }
     # else
      # format.html { redirect_to(@idea, :notice =>
       # 'Error')}
       # format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
    #end
   redirect_to idea_path , :notice => 'like was successfully created.'
  else
     redirect_to idea_path , :notice => 'You already liked that before .'

  end
  end/

  /def like
    @idea = Idea.find(params[:idea_id])
    @Comment = @idea.comments.find(params[:id])
    @like = Like.new(params[:comment_id][:user_id])
    @user = User.first
    @like.save
       redirect_to idea_path , :notice => 'like was successfully created.'

  end/
#create new like
#Params:
#+User_id+ :: the parameter is an instance
#of +User+ passed to get the id of the user to build the like
#+comment_id+ :: the parameter is an instance
# of +Comment+ and it's used to build the like after clicking like
#The def checks if the user liked the comment before if not the num_likes is incremented
#by 1 else nothing happens
#author dayna

      def like
  #@current_user =  User.find(params[:id])
  #@current_user =  User.first
  #@idea = Idea.find(params[:idea_id])
  @comment = Comment.find(params[:id])
  #@like = Like.new(params[:comment_id => @comment][:user_id => @current_user])
  ##@comment.update_attribute(:num_likes , num_likes+1)
  #if Like.find(params[:comment_id]) == @comment
  # && Like.find(params[:user_id]) == @current_user
#else
  @comment.num_likes += 1
  # @comment.num_likes + 1
  ##@like = @comment.num_likes
  #if @like.save
   #    format.html { redirect_to(@idea, :notice => 'like was successfully created.') }
    #   format.xml  { render :xml => @idea, :status => :created, :location => @idea }
     # else
      # format.html { redirect_to(@idea, :notice =>
       # 'Error')}
       # format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
   # end
   redirect_to idea_path , :notice => 'like was successfully created.'
  end
end
#Destory a like
#Params:
#+User_id+ :: the parameter is an instance
#of +User+ passed to get the id of the user to get the id of the user
#who liked the comment
#+comment_id+ :: the parameter is an instance
# of +Comment+ and it's used to get the id of the comment 
#The def checks if the user liked the comment before if yes the num_likes is decremented 
#by 1 and the like is destroyed 
#author dayna

def unlike
@like = Like.find(params[:user_id][:comment_id])
    #@story = @like.story
    @like.destroy

    respond_to do |format|
      format.html { redirect_to idea_path }
      format.js
      format.json { head :ok }
    end
end

