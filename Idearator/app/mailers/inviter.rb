class Inviter < ActionMailer::Base
  default from: "idearator.cool@gmail.com"

# returns invitation email
# Params:
# +email+:: the email of the guest
# Author: muhammed hassan
   def invite_email(email )
    @email = email
    @type = 'committee'
    @address = 'idearator'
    return mail(:to => email, :subject => "Welcome to My Awesome Site")
  end
	# Sends mail confirming registration
	# 
	# Params: 
	# +email+:: the parameter is an instance of +User.email+ passed through the button_to Approve Committee
	# Author: Mohammad Abdulkhaliq
  def committee_accept(email)
    @email = email
    @type = 'committee'
    @address = 'idearator'
    mail(:to => email, :subject => "Congratulations!")
  end
	# Sends mail rejecting registration
	# 
	# Params: 
	# +email+:: the parameter is an instance of +User.email+ passed through the button_to Approve Committee
	# Author: Mohammad Abdulkhaliq
  def committee_reject(email)
    @email = email
    @type = 'user'
    @address = 'idearator'
    mail(:to => email, :subject => "Idearator")
  end

end
