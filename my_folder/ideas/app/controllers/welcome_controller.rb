class WelcomeController < ApplicationController
  
  def index
  end

  def invite_committee
  	InvitedPerson.create(:email => params[:email] , :committee => true , :admin => false)
  	mail = Inviter.invite_email(params[:email] , 'committee')
  	mail.deliver
  end
end
