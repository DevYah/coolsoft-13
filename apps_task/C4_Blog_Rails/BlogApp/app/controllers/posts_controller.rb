class PostsController < ApplicationController

  # GET /posts/1
  # GET /posts/1.json
  def show
        @blog = Blog.find(:first, :conditions => { :user_id => session[:user_id] })
        @blog2 = Blog.find(:first, :conditions => { :id => session[:blog_id] })
    @post = Post.find(params[:id])
    @comment = Comment.find(params[:id])
     rescue ActiveRecord::RecordNotFound

    if params[:user_id] == session[:user_id]
      @authenticated = true
     #else 
     #@authenticated = nil
     end 

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
        @blog = Blog.find(:first, :conditions => { :user_id => session[:user_id] })
        @blog2 = Blog.find(:first, :conditions => { :id => session[:blog_id] })

        if params[:user_id] == session[:user_id]
           @authenticated = true
     #else 
     #@authenticated = nil
     end 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit  
    if params[:user_id] == session[:user_id]
      @authenticated = true
     #else 
     #@authenticated = nil
     end 
    @blog = Blog.find(:first, :conditions => { :user_id => session[:user_id] })
    @blog2 = Blog.find(:first, :conditions => { :id => session[:blog_id] })
    @comment = Comment.find(params[:comment_id])
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    if params[:user_id] == session[:user_id]
      @authenticated = true
     #else 
     #@authenticated = nil
     end 
        @blog = Blog.find(:first, :conditions => { :user_id => session[:user_id] })
        @blog2 = Blog.find(:first, :conditions => { :id => session[:blog_id] })
    @post = Post.new(params[:post])
     @curr_blog = Blog.find(:first, :conditions => { :user_id => session[:user_id] })
     @post.update_attributes(:blog_id => @curr_blog.id)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    if params[:user_id] == session[:user_id]
      @authenticated = true
     #else 
     #@authenticated = nil
     end 
    @post = Post.find(params[:id])
        @blog = Blog.find(:first, :conditions => { :user_id => session[:user_id] })
        @blog2 = Blog.find(:first, :conditions => { :id => session[:blog_id] })
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if params[:user_id] == session[:user_id]
      @authenticated = true
     #else 
     #@authenticated = nil
     end 
    @post = Post.find(params[:id])
    @post.destroy
    @blog = Blog.find(:first, :conditions => { :user_id => session[:user_id] })

    respond_to do |format|
      format.html { redirect_to @blog }
      format.json { head :no_content }
    end
  end
end
