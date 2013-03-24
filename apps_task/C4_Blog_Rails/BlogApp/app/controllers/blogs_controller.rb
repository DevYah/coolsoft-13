class BlogsController < ApplicationController

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    @posts = Post.find(:all, :conditions => { :blog_id => @blog.id })
    @search = Post.search do 
      fulltext params[:search]
    end
      @posts = @search.results
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    
  end
  end 


	def new
	@blog = Blog.new
	end

	def create
    @blog = Blog.new(params[:blog])
    @blog.update_attributes(:user_id => session[:user_id])
    if @blog.save
      redirect_to root_url, notice: "Your blog has been created!"
    else
      render "new"
    end
  end
  
  def edit
    @blog = Blog.find(:first, :conditions => { :user_id => session[:user_id] })
  end

  def update
    @blog = Blog.find(:first, :conditions => { :user_id => session[:user_id] })
    @blog.update_attributes(params[:blog])
    if @blog.save
      redirect_to root_url, notice: "Your blog has been renamed!"
    else
      render "edit"
    end
  end
end
