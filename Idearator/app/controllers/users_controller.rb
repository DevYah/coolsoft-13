 

class UsersController < ApplicationController
	before_filter :authenticate_user!, :only => [:deactivate, :confirm_deactivate, :activate, :expertise, :new_committee_tag, :invite_member, :reject_invitation]
  
	# displays a form where the user enters his password to confrim deactivation.
	# Params: none
	# Author: Amina Zoheir
	def confirm_deactivate
		@user = current_user
	end
  
	# checks the entered password if it's the current users password 
	# it changes the value of his active field to false and signs him out. 
	# Params: 
	# +password+:: the parameter is an instance of +User+ passed through the form form confirm deactivate.
	# Author: Amina Zoheir
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
  
  # sets the active field of the current user to true
  # Params: none
  # Author: Amina Zoheir
  def activate
    current_user.active = true
    respond_to do |format|
      format.html { falsh[:notice] = 'Successfully reactivated' }
      format.json { head :no_content }
    end
  end
  
	# Pass the current_user and all the tags to the  expertise view
	# Params:
	# none
	# Author: Mohamed Sameh
	def expertise
		if current_user.is_a? Committee
			if Tag.all.count > 0
				@user= current_user
				@tags= Tag.all
			else
				respond_to do |format|
				format.html{
					redirect_to controller: 'home', action: 'index'
				}
			  end
      end
			else
				respond_to do |format|
				format.html{
					redirect_to controller: 'home', action: 'index'
				}
			   end
			 end
			end
  
	# Enter chosen tags sent from expertise view, in committeestags table 
  # If the current user of the action is invited then a notification 
  # is sent to the admin informing of user acceptance of invitation.
	# Params:
	# +tags[]+:: the parameter is ana instance of +tag+ passed through the form from expertise action
	# Author: Mohamed Sameh
	def new_committee_tag
		if params[:user] == nil
			respond_to do |format|
				format.html{
					flash[:notice] = 'You must choose at least 1 area of expertise'
					redirect_to action: 'expertise'
				}
			end
		else
			@tags= params[:user][:tags]
			@tags.each do |tag|
				CommitteesTags.create(:committee_id => current_user.id , :tag_id => tag)
			end
      notf = InviteCommitteeNotification.where(:user_id => current_user.id)[0]
      if InviteCommitteeNotification.where(:user_id => current_user.id).exists?
        notf = InviteCommitteeNotification.where(:user_id => current_user.id)[0]
        @admin = Admin.find(notf.user_id) 
      InviteCommitteeNotification.send_notification(User.find(current_user.id), @admin) 
      InviteCommitteeNotification.find(notf).destroy
    end
			respond_to do |format|
				format.html{
					redirect_to controller: 'home', action: 'index'
				}
			end
		end
	end
  
  #This method is used to generate the view of each User Profile. A specific user and his ideas are made
  #available to the view to be presented in the appropriate manner.
  #Author: Hisham ElGezeery
  def show
    @user = User.find(params[:id])
    @ideas = Idea.find(:all, :conditions => { :user_id => @user.id })
    @invited = InviteCommitteeNotification.where(:user_id => params[:id]).exists?
    @tags = Tag.all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
  	end
  end
	
  # Rejects an admin invitaion to become a committee and the committee record is removed from db
	# by removing his committee status
	# Params: 
	# +id+:: the parameter is an instance of +User+ passed through the button_to Approve Committee
	# Author: Mohammad Abdulkhaliq
  def reject_invitation
    @user = User.find(current_user.id)
    id = current_user.id
    @user.type = nil
    @user.save
    current_user = User.find(id)
    InviteCommitteeNotification.send_notification(current_user, Admin.all)
    InviteCommitteeNotification.where(:user_id => id)[0].destroy
		respond_to do |format|
			format.html { redirect_to controller: 'home', action: 'index' , notice: 'Rejected Invitation to become Committee' }
			format.json { head :no_content }
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

  # Invites existing member to become a committee 
  # by initiating him into the database and then sending him a notification
  # Params: 
  # +id+:: the parameter is an instance of +User+ passed through the button_to Approve Committee
  # Author: Mohammad Abdulkhaliq
  def invite_member
    @user = User.find(params[:id])
    @user.type = 'Committee'
    @user.approved = true
    @user.save
    InviteCommitteeNotification.send_notification(current_user, [@user])
    respond_to do |format|
      format.html { redirect_to  '/' , notice: 'Successfully invited member' }
			format.json { head :no_content }
    end
  end
end
