require 'sequel'
Sequel::Model.db = Sequel.sqlite './database/db.sqlite'

class Note < Sequel::Model

end
