class AdminsController < ApplicationController

##
# redirects to the index page
	def index
	end
##
# sends invitation mail and stores the invitation in the database
# +email+:: the email of the  guest
# Author: muhammed hassan
	def invite_committee
		if User.find(:all, :conditions => {:email => params[:email]}).length ==0
			Invited.create(:email => params[:email] , :admin_id=> 5 )
			# after integrating with login 5 shoulld be replaced with current_user.id
	  		mail = Inviter.invite_email(params[:email])
	  		mail.deliver
	  		@messege = 'success'
	  	else
	  		@messege = 'failure'
	  	end
	end
end
