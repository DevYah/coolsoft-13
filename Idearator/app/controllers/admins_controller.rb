class AdminsController < ApplicationController
  
	

	# Sends mail confirming registration 
	# 
	# Params: 
	# +id+:: the parameter is an instance of +User+ passed through the button_to Approve Committee
	# Author: Mohammad Abdulkhaliq
  def approve_committee
    @user = User.find(params[:id])
  
    respond_to do |format|

         UserMailer.committee_accept(@user).deliver
         format.html  { redirect_to('/',
                       :notice => 'User successfully initiated as a Committee.') }
         format.json  { head :no_content }
       end
     end
 	# Remove the user's status as a committtee
 	# Then sends a mail notifiying him of what happened.
 	# Params: 
 	# +id+:: the parameter is an instance of +User+ passed through the button_to Approve Committee
 	# Author: Mohammad Abdulkhaliq
   def reject_committee
     @user = User.find(params[:id])
     @user.type = nil
     respond_to do |format|
        if @user.save
          UserMailer.committee_reject(@user).deliver
          format.html  { redirect_to(admins_path,
                        :notice => 'User successfully initiated as a Committee.') }
          format.json  { head :no_content }
        else
          format.html  { redirect_to(admins_path,
                        :notice => @user.errors.full_messages) }
          format.json  { render :json => :no_content }
        end
      end
    end
end