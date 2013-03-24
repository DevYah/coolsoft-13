class WelcomeController < ApplicationController
  def index
  end

  def invite
  	mail = Inviter.invite_email(params[:email] , params[:type])
  	mail.deliver
  	redirect_to(:action => 'index')
  end
end
