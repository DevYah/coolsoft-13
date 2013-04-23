class UserMailer < ActionMailer::Base

  #This method sends an email to the Admin
  #if a user signed up as committee to inform them
  #that they should accept/reject their application
  #Params: admin
  #Author: Menna Amr
  def committee_signup(admin)
  	mail(:to => admin, :subject => "New Committee Member Sign Up")
  end
  
  def committee_accept(user)
    @user = user
    @url  = "http://localhost:3000/users/login"
    mail(:to => user.email, :subject => "Congratulations!")
  end
  
end
