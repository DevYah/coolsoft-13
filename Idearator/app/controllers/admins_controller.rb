class AdminsController < ApplicationController
	def index
	end

	def invite_committee
		if User.find(:all, :conditions => {:email => params[:email]}).length ==0
			Invited.create(:email => params[:email] , :admin_id=> 5 )
	  		mail = Inviter.invite_email(params[:email])
	  		mail.deliver
	  		@messege = 'success'
	  	else
	  		@messege = 'failure'
	  	end
	end
end
