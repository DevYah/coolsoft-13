class UserMailer < ActionMailer::Base
  default from: "menna.amr2@gmail.com"

    def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/users/login"
    mail(:to => user.email, :subject => "Welcome to Shoghlana!")
  end
  
  # Sends mail confirming registration
	# Params: 
	# +email+:: the parameter is an instance of +User.email+ passed through the button_to Approve Committee
	# Author: Mohammad Abdulkhaliq
  def committee_accept(user)
    @user = user
    @url  = "http://localhost:3000/users/login"
    mail(:to => user.email, :subject => "Congratulations!")
  end
	
	# Sends mail rejecting registration
	# Params: 
	# +email+:: the parameter is an instance of +User.email+ passed through the button_to Approve Committee
	# Author: Mohammad Abdulkhaliq
  def committee_reject(user)
    @user = user
    @url  = "http://localhost:3000/users/login"
    mail(:to => user.email, :subject => "Idearator")
  end
  
end
