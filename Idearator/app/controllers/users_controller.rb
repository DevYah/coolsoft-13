class UsersController < ApplicationController

	before_filter :authenticate_user!, :only => [:deactivate, :confirm_deactivate, :activate]

	#method displays a form where the user enters his password to confrim deactivation.
	#Params: none
	#Author: Amina Zoheir
	def confirm_deactivate
		@user = current_user
	end

	#method checks the entered password if it's the current users password 
	#it changes his status to deactivated and signs him out. 
	#Params: 
	#password:: the parameter is an instance of User passed through the form form confirm deactivate.
	#Author: Amina Zoheir
	def deactivate
		if current_user.password == params[:user][:password]
			current_user.status = "deactivated"
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

	#method sets the status of the current user to active
	#Params: none
	#Author: Amina Zoheir
	def activate
		current_user.status = "active"
		respond_to do |format|
			format.html { falsh[:notice] = 'Successfully reactivated' }
			format.json { head :no_content }
		end
	end
end
