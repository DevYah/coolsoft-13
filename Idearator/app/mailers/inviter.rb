class Inviter < ActionMailer::Base
  default from: "coolsoftc2@gmail.com"

##
# returns invitation email
# Params:
# +email+:: the email of the rec
# Author: muhammed hassan
   def invite_email(email )
    @email = email
    @type = 'committee'
    @address = 'idearator.com'
    return mail(:to => email, :subject => "Welcome to My Awesome Site")
  end

end
