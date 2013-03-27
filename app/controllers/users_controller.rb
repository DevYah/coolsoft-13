class UsersController < ApplicationController

	def confirm_deactivate
		@user = current_user
	end

	def deactivate
		if current_user.password == params[:user][:password]
			current_user.status = "deactivated"
			current_user.save
			#sign_out current_user
			respond_to do |format|
				format.html { redirect_to  '/' , notice: 'Successfully deactivated' }
				format.json { head :no_content }
			end
		else
			respond_to do |format|
				format.html { redirect_to action: 'confirm_deactivate' , notice: 'Wrong password'}
				format.json { head :no_content }
			end
		end
	end

	def activate
		current_user.status = "active"
		respond_to do |format|
			format.html { falsh[:notice] = 'Successfully reactivated' }
			format.json { head :no_content }
		end
	end
end
