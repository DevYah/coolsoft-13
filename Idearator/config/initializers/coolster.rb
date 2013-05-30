if Rails.env == 'development'
  COOLSTER_URL = "http://localhost:9292"
elsif Rails.env == 'production'
  COOLSTER_URL =  ENV['COOLSTER_URL'] 
end