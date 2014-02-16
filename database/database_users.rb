require "sequel"

DB = Sequel.sqlite "db.sqlite"

DB.create_table? :users do
  primary_key :id
  String :username, :unique => true
  String :password
end
