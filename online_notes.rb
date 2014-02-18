require 'sinatra'

enable :sessions
enable :logging

Dir.glob('./{models}/*.rb').each { |file| require file }

get '/' do
  haml :home
end

get '/login' do
  haml :login
end

get '/register' do
  haml :register
end

not_found do
  haml :not_found
end

