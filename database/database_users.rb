require "sequel"

DB = Sequel.sqlite "database/db.sqlite"

DB.create_table? :users do
  primary_key :id
  String :username, :unique => true
  String :email, :unique => true
  String :crypted_password
end
