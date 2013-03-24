class Inviter < ActionMailer::Base
  default from: "from@example.com"

  def invite_email(email , type )
    @email = email
    @url  = "http://example.com/login"
    @type = type
    @address = "example.com"
    return mail(:to => email, :subject => "Welcome to My Awesome Site")
  end

end
