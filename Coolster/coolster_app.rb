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
  @@guests = {}
  @@saved_scripts = {}

  def self.http_options(path, opts={}, &block)
    route 'OPTIONS', path, opts, &block
  end

  def new
    super
  end

  before do
    response.headers['Access-Control-Allow-Origin']  = IDEARATOR_DOMAIN + ''
    response.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'X-CSRF-Token'
  end

  http_options '/' do
    halt 200
  end

  # Adds an new proc to the users hash with the users id as the key to be called later
  # in any of the /push methods and sends an http post request to CoolsterController with this id.
  # Does the same for the guest, adds a new proc to the guest hash with the session id as the key to be called later
  # in /push_to_all.
  # Params: none
  # Author: Amina Zoheir
  aget '/poll' do
    puts "polling"
    if env['warden'].authenticated?
      puts @@saved_scripts[request.session.id]
      if @@saved_scripts[env['warden'].user[1][0].to_s].nil? || @@saved_scripts[env['warden'].user[1][0].to_s] == []
        @@users[env['warden'].user[1][0].to_s] = Proc.new{|script| body script}
        EventMachine::HttpRequest.new(IDEARATOR_URL + '/coolster/add_online_user').post :body => {user: env['warden'].user[1][0]}
      else
        body @@saved_scripts[env['warden'].user[1][0].to_s][0]
        @@saved_scripts[env['warden'].user[1][0].to_s].delete_at(0)
      end    
    else
      if @@saved_scripts[request.session.id].nil? || @@saved_scripts[request.session.id] == [] 
        @@guests[request.session.id] = Proc.new{|script| body script}
      else
       body @@saved_scripts[request.session.id]
       @@saved_scripts[request.session.id].delete_at[0] 
      end
    end
  end

  # This is called by Idearator to push a javascript to specified users.
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
          EventMachine::HttpRequest.new(IDEARATOR_URL + '/coolster/remove_online_user').post :body => {user: user}
        end
      else
        @@users[user].call params[:script]
        @@users[user] = nil
      end
    end
    body "ok"
  end

  # This is called by Idearator to push a javascript to all online users (users and guests)
  # Calls all procs in the users hash and the guests hash.
  # Params:
  # +script+:: the parameter is a string (javascript) passed through Coolster#update_all.
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
          EventMachine::HttpRequest.new(IDEARATOR_URL + '/coolster/remove_online_user').post :body => {user: key}
        end
      else
        value.call params[:script]
        @@users[key] = nil
      end
    end
    @@guests.each do |key, value|
      if value.nil?
        if @@saved_scripts[key].nil?
          @@saved_scripts[key] = []
        end
        @@saved_scripts[key] << params[:script]
        if @@saved_scripts[key].length > 5
          @@guests.delete(key)
          @@saved_scripts.delete(key)
        end
      else
        value.call params[:script]
        @@guests[key] = nil
      end
    end
    body "ok"
  end

  # This is called by Idearator to push javascripts to users, each user has his specific javascript.
  # Calls all procs in the users hash and the guests array.
  # Params:
  # +scripts+:: the parameter is a hash of strings (javascripts) passed through Coolster#update_each.
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
          EventMachine::HttpRequest.new(IDEARATOR_URL + '/coolster/remove_online_user').post :body => {user: user}
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
