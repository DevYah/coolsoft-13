class UsersController < ApplicationController

  #This method is used to generate the view of each User Profile. A specific user and his ideas are made
  #available to the view to be presented in the appropriate manner.
  #Author: Hisham ElGezeery
  def show
    @user = User.find(params[:id])
    @ideas = Idea.find(:all, :conditions => { :user_id => @user.id })

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
  	end
  end 

	# POST /users
  # POST /users.json
	
  # This method creates a new User and calls UserMailer to send a confirmation email.
  #Author: Menna Amr
  def create
    @user = User.new(params[:user])
 
    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome Email after save
        UserMailer.welcome_email(@user).deliver
 
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end
