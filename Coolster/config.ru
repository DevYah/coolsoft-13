require './coolster_app'

if ENV['RACK_ENV'] == 'development'
  IDEARATOR_DOMAIN = "localhost:3000"
  IDEARATOR_URL = "http://" + IDEARATOR_DOMAIN
elsif ENV['RACK_ENV'] == 'production'
  IDEARATOR_DOMAIN = ENV['IDEARATOR_DOMAIN']
  IDEARATOR_URL = "http://" + IDEARATOR_DOMAIN
end

use Rack::Session::Cookie, :key => '_Sprint0_session', :secret => '9278cc6b165cd0a707dab50893232e9210a85bda302d113ab33a2dfe24a16f9f9f89e7f09c98d9251d1377b00e79b7de032eccc2fc9f0041584d7bf608bd5f81'


use Warden::Manager do |manager|
  manager.failure_app = CoolsterApp
  manager.default_scope = 'user'
end

Warden::Manager.before_failure do |env, opts|
  env['REQUEST_METHOD'] = "POST"
end

run CoolsterApp

