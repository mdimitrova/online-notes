require 'sequel'

DB = Sequel.sqlite "db.sqlite"

DB.create_table? :notes do
  primary_key :id
  foreign_key(:user_id, :users)
  String :title
  String :text
  String :tags
  String :notebook
end
