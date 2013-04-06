class AdminsController < ApplicationController
	def index
	end

	def invite_committee
		Invited.create(:email => params[:email] , :admin_id=> 5)
  		mail = Inviter.invite_email(params[:email])
  		mail.deliver
	end
end