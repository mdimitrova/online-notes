require 'sinatra'

enable :sessions
enable :logging
set :session_secret, 'super secret'

Dir.glob('./{models}/*.rb').each { |file| require file }

get '/' do
  haml :home, locals: {:welcome_message => "Welcome to Online notes :)"}
end

get '/login' do
  haml :login
end

post '/login' do
  user = User.authenticate(params[:username], params[:password])
  if user
    session[:user] = user
    redirect "/notes"
  else
    haml :login, locals: {:authentication_error => "Incorrect login data. Try again"}
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
    redirect "/notes"
  else
    haml :login
    redirect '/register'
  end
end

get '/notes' do
  @notes = Note.where :user_id => session[:user].id if session[:user]
  haml :notes
end

get '/notes/create' do
  haml :create
end

post '/notes/create' do
  puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> #{params}"
  note = Note.create(:title => "fucking title")
  note.save
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
