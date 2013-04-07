class AdminsController < ApplicationController


	def invite_member
		@user = User.find(params[:id])
		@user.type = 'Committee'
		@user.save
		InviteCommitteeNotification.send_notification(current_user, User.find(params[:id]))
		respond_to do |format|
        format.html { redirect_to  'admins/index' , notice: 'Successfully invited member' }
        format.json { head :no_content }
      end
	end


end
