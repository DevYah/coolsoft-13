class Inviter < ActionMailer::Base
  default from: "from@example.com"

   def invite_email(email )
    @email = email
    @type = 'committee'
    @address = 'idearator.com'
    return mail(:to => email, :subject => "Welcome to My Awesome Site")
  end

end
