# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

require './Coolster/coolster_app'

map "/" do
 run Sprint0::Application
end

map "/coolster_app" do

  use Rack::Session::Cookie, :key => '_Sprint0_session', :secret => Sprint0::Application.config.secret_token

  use Warden::Manager do |manager|
    manager.failure_app = CoolsterApp
    manager.default_scope = Devise.default_scope
  end

  Warden::Manager.before_failure do |env, opts|
    ev['REQUEST_METHOD'] = "POST"
  end

  run CoolsterApp

end