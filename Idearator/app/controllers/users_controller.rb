 


class UsersController < ApplicationController
	before_filter :authenticate_user!, :only => [:deactivate, :confirm_deactivate, :activate, :expertise, :new_committee_tag]

	#method displays a form where the user enters his password to confrim deactivation.
	#Params: none
	#Author: Amina Zoheir
	def confirm_deactivate
		@user = current_user
	end
	#method checks the entered password if it's the current users password 
	#it changes the value of his active field to false and signs him out. 
	#Params: 
	#password:: the parameter is an instance of User passed through the form form confirm deactivate.
	#Author: Amina Zoheir
	def deactivate
		if current_user.is_a? Committee
			@password = params[:committee][:password]
		else
			@password = params[:user][:password]
		end
		
		if current_user.valid_password?(@password)
			current_user.active = false
			current_user.save
			sign_out current_user
			respond_to do |format|
				format.html { redirect_to  '/' , notice: 'Successfully deactivated' }
				format.json { head :no_content }
			end
		else
			respond_to do |format|
				format.html { redirect_to action: 'confirm_deactivate'
							  flash[:notice] = '
							  Wrong password'}
				format.json { head :no_content }
			end
		end
	end
	#method sets the active field of the current user to true
	#Params: none
	#Author: Amina Zoheir
	def activate
		current_user.active = true
		respond_to do |format|
			format.html { falsh[:notice] = 'Successfully reactivated' }
			format.json { head :no_content }
		end
	end
  
  #This method is used to generate the view of each User Profile. A specific user and his ideas are made
  #available to the view to be presented in the appropriate manner.
  #Author: Hisham ElGezeery
  def show
    @user = User.find(params[:id])
    @ideas = Idea.find(:all, :conditions => { :user_id => @user.id })
    @registered = @user.approved == false
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

  before_filter :authenticate_user!, :only => [:approve_committee, :reject_committee]
  # Sends mail confirming registration
  # Params: 
  # +id+:: the parameter is an instance of +User+ passed through the button_to Approve Committee
  # Author: Mohammad Abdulkhaliq
  def approve_committee
	  if(not current_user.is_a? Admin)
      redirect_to '/', :notice => 'Please sign in as an admin' 
      return
    end
	  @user = User.find(params[:id])
    @user.approved = true
    @user.save
    respond_to do |format|
      Inviter.committee_accept(@user.email).deliver
      format.html  { redirect_to('/', :notice => 'User successfully initiated as a Committee.') }
      format.json  { head :no_content }
    end
  end
  
  # Remove the user's status as a committtee
  # Then sends a mail notifiying him of what happened.
  # Params: 
  # +id+:: the parameter is an instance of +User+ passed through the button_to Approve Committee
  # Author: Mohammad Abdulkhaliq
   def reject_committee
    if(not current_user.is_a? Admin)
      redirect_to '/', :notice => 'Please sign in as an admin'
      return
    end
    @user = User.find(params[:id])
    @user.type = nil
    respond_to do |format|
      if @user.save
        Inviter.committee_reject(@user.email).deliver
        format.html  { redirect_to('/', :notice => 'User successfully rejected as a Committee.') }
        format.json  { head :no_content }
      else
        format.html  { redirect_to('/', :notice => @user.errors.full_messages) }
        format.json  { render :json => :no_content }
      end
    end
  end
end
