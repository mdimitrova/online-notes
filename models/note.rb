require 'sequel'
Sequel::Model.db = Sequel.sqlite './database/db.sqlite'

class Note < Sequel::Model
  def tags
    tags = self[:tags].split(' ,').to_a
  end
end
