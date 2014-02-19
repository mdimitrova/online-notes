require 'sinatra'

enable :sessions
enable :logging
set :session_secret, 'super secret'

Dir.glob('./{models}/*.rb').each { |file| require file }

get '/' do
  haml :home
end

get '/login' do
  haml :login
end

post '/login' do
  user = User.authenticate(params[:username], params[:password])
  if user
    session[:user] = user
    redirect '/'
  else
    haml :login, locals: {:authentication_error => true}
    redirect '/login'
  end
end

get '/register' do
  haml :register
end

post '/register' do
  user = User.create(params)
  if user.valid? #FIXME
      user.save
      session[:user] = user
      redirect '/'
  else
    haml :login, locals: {:authentication_error => true}
    redirect '/register'
  end
end

get '/notes' do
  haml :notes
end

get '/notebooks' do
  haml :notebooks
end

get '/tags' do
  haml :tags
end

get '/logout' do
  session.delete :user
  redirect '/'
end

not_found do
  haml :not_found
end
