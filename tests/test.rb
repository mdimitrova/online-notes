ENV['RACK_ENV'] = 'test'

require 'rspec'
require './online_notes'
require 'rack/test'

set :environment, :test

include Rack::Test::Methods

def app
  Sinatra::Application
end

def login
  post '/login', { :username => 'monica', :password => 'lalala' }
end

describe 'User' do
  it 'register a new user' do
    post '/register', { :username => 'teafreak', :email => 'asdf@gmail.com', :password => 'passwordpassword'}
    last_response.should be_redirect
    last_response.location.should end_with '/notes'
  end

  it 'login' do
    post '/login', { :username => 'monica', :password => 'lalala'}
    last_response.should be_redirect
    last_response.location.should end_with '/notes'
  end

  it 'logout' do
    login
    get '/logout'
    last_response.should be_redirect
    last_response.location.should end_with '/'
  end

  after(:all) do
    user = User.find(:username => 'teafreak')
    user.delete
  end
end
