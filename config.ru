require './coolster_app'
require ::File.expand_path('../../Idearator/config/environment',  __FILE__)

if Rails.env == 'development'
  IDEARATOR_URL = "localhost:3000"
elsif Rails.env == 'production'
  IDEARATOR_URL = ""
end

use Rack::Session::Cookie, :key => '_Sprint0_session', :secret => Sprint0::Application.config.secret_token

use Warden::Manager do |manager|
  manager.failure_app = CoolsterApp
  manager.default_scope = 'user'
end

Warden::Manager.before_failure do |env, opts|
  env['REQUEST_METHOD'] = "POST"
end

run CoolsterApp

