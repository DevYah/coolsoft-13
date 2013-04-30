require 'warden'
require 'sinatra/async'
require 'rest_client'
require 'em-http-request'

class CoolsterApp < Sinatra::Base
  register Sinatra::Async

  configure do
    enable :logging, :dump_errors, :raise_errors, :show_exceptions
  end

  @@users = {}
  @@guests = []
  @@saved_scripts = {}

  def self.http_options(path, opts={}, &block)
    route 'OPTIONS', path, opts, &block
  end

  def new
    super
  end

  before do
    response.headers['Access-Control-Allow-Origin']  = 'localhost:3000'
    response.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'X-CSRF-Token'
  end

  http_options '/' do
    halt 200
  end

  # Checks if there is a current user adds a proc to the users hash with the users id as the key 
  # and sends an http post request to CoolsterController with this id.
  # else adds a proc in the guests array.
  # Params: none
  # Author: Amina Zoheir
  aget '/poll' do
    puts "polling"
    if env['warden'].authenticated?
      if @@saved_scripts[env['warden'].user[1][0].to_s].nil? || @@saved_scripts[env['warden'].user[1][0].to_s] == []
        @@users[env['warden'].user[1][0].to_s] = Proc.new{|script| body script}
        EventMachine::HttpRequest.new('http://localhost:3000/coolster/add_online_user').post :body => {user: env['warden'].user[1][0]}
      else
        body @@scripts[env['warden'].user[1][0].to_s][0]
        @@scripts[env['warden'].user[1][0].to_s].remove_at(0)
      end    
    else
      @@guests << Proc.new{|script| body script}
    end
  end

  # Calls the procs of the users in the array.
  # Params:
  # +script+:: the parameter is an string (javascript) passed through Coolster#update.
  # +users+:: the parameter is an array of strings passed through Coolster#update.
  # Author: Amina Zoheir
  apost '/push' do
    puts "updating1"
    puts params[:users]
    params[:users].each do |user|
      if @@users[user].nil?
        if @@saved_scripts[user].nil?
          @@saved_scripts[user] = []
        end
        @@saved_scripts[user] << params[:script]
        if @@saved_scripts[user].length > 5
          @@users.delete(user)
          @@saved_scripts.delete(user)
          EventMachine::HttpRequest.new('http://localhost:3000/coolster/remove_online_user').post :body => {user: user}
        end
      else
        @@users[user].call params[:script]
        @@users[user] = nil
      end
    end
    body "ok"
  end

  # Calls all procs in the users hash and the guests array.
  # Params:
  # +script+:: the parameter is an string (javascript) passed through Coolster#update_all.
  # Author: Amina Zoheir
  apost '/push_to_all' do
    puts "updating2"
    @@users.each do |key, value|
      if value.nil?
        if @@saved_scripts[key].nil?
          @@saved_scripts[key] = []
        end
        @@saved_scripts[key] << params[:script]
        if @@saved_scripts[key].length > 5
          @@users.delete(key)
          @@saved_scripts.delete(key)
          EventMachine::HttpRequest.new('http://localhost:3000/coolster/remove_online_user').post :body => {user: key}
        end
      else
        value.call params[:script]
        @@users[key] = nil
      end
    end
    @@guests.each do |guest|
      guest.call params[:script]
    end
    body "ok"
  end

  # Calls all procs in the users hash and the guests array.
  # Params:
  # +scripts+:: the parameter is a hash of strings (javascripts) passed through Coolster#update_all.
  # Author: Amina Zoheir
  apost '/push_to_each' do
    puts "updating3"
    params[:scripts].each do |user, script|
      if @@users[user].nil?
        if @@saved_scripts[user].nil?
          @@saved_scripts[user] = []
        end
        @@saved_scripts[user] << script
        if @@saved_scripts[user].length > 5
          @@users.delete(user)
          @@saved_scripts.delete(user)
          EventMachine::HttpRequest.new('http://localhost:3000/coolster/remove_online_user').post :body => {user: user}
        end
      else
        @@users[user].call script
        @@users[user] = nil
      end
    end
    body "ok"
  end

  aget '/' do
    body "ok"
  end

end
