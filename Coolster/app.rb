require 'sinatra/async'

class Coolster < Sinatra::Base
  register Sinatra::Async

  # Create a new HTTP verb called OPTIONS.
  # Browsers (should) send an OPTIONS request to get Access-Control-Allow-* info.
  def self.http_options(path, opts={}, &block)
    route 'OPTIONS', path, opts, &block
  end

  def new
    @users = {}
    super
  end

  # Ideally this would be in http_options below. But not all browsers send
  # OPTIONS pre-flight checks correctly, so we'll just send these with every
  # response. I'll discuss what some of them mean in Part 2.
  before do
    response.headers['Access-Control-Allow-Origin']  = 'localhost:3000' # If you need multiple domains, just use '*'
    response.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'X-CSRF-Token' # This is a Rails header, you may not need it
  end

  # We need something to respond to OPTIONS, even if it doesn't do anything
  http_options '/' do
    halt 200
  end

  aget '/' do
    body 'Hello'
    puts request.cookies
  end

  aget '/poll' do
    body 'Amina'
    @users = Mutex.new
    @users.lock
    puts request.cookies
    #authenticate
    #add thread to hash
  end

  apost '/update' do
    puts params[:script]
  end

end