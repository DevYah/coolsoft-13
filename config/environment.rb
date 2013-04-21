# Load the rails application
require File.expand_path('../application', __FILE__)

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address            => 'smtp.gmail.com',
  :port               => 587,
  :tls                  => true,
  :domain             => 'gmail.com',
  :authentication     => :plain,
  :user_name          => 'idearator.13@gmail.com',
  :password           => 'idearator13'
}

# Initialize the rails application
Sprint0::Application.initialize!
