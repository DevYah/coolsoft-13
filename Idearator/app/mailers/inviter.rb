class Inviter < ActionMailer::Base
  default from: "coolsoft@gmail.com"

   def invite_email(email )
    @email = email
    @type = 'committee'
    @address = 'idearator.com'
    return mail(:to => email, :subject => "Welcome to My Awesome Site")
  end

end
