class UsersController < ApplicationController

	before_filter :authenticate_user!, :only => [:deactivate, :confirm_deactivate, :activate]

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
		if current_user.password == params[:user][:password]
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

	# POST /users
  # POST /users.json
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
