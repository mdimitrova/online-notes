require 'sinatra'
require "./models/note"
require "./models/user"

get '/' do
  @title = "Online notes"
  'Hello there :)'
end

not_found do
  haml :not_found
end
