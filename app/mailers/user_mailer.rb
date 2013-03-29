class UserMailer < ActionMailer::Base
  default from: "idearator.13@gmail.com"

#Sends email to user after Sign Up
#Params:
#user, passed through the ActionMailer
#Author: Menna Amr
  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/users/login"
    mail(:to => user.email, :subject => "Welcome to Idearator!")
  end
end
