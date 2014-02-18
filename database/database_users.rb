require "sequel"

DB = Sequel.sqlite "db.sqlite"

DB.create_table? :users do
  primary_key :id
  String :username, :unique => true
  String :email, :unique => true
  String :password
end

users = DB[:users] #create a dataset

users.insert(:username => 'monica', :password => 'lalala', :email => 'monicabdimiteova@gmail.com')

users.filter(:username => 'monica').each { |user| puts user[:password] }
