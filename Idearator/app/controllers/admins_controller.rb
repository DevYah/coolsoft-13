class AdminsController < ApplicationController
  before_filter do 
    unless current_user and current_user.is_a? Admin
      redirect_to '/home/index'
    end
  end

  def invite
  end

# checks invitation is valid and delivers the email
# +email+:: the email of the  guest
# Author: muhammed hassan
  def invite_committee
    if User.find(:all, :conditions => {:email => params[:email]}).length ==0
      i = Invited.creates( params[:email] , current_user.id )
      # after integrating with login 5 shoulld be replaced with current_user.id
      if i.valid? 
        mail = Inviter.invite_email(params[:email])
        mail.deliver
        @messege = 'success'
      else
        @messege = i.errors.full_messages
      end
    else
      @messege = 'user already exists'
    end
  end
end
