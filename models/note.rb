require 'sequel'
Sequel::Model.db = Sequel.sqlite './database/db.sqlite'

class Note < Sequel::Model
  def title=(input_title)
    self[:title] = input_title
  end

  def text=(input_text)
    self[:text] = input_text
  end

  def tags=(input_tags)
    self[:tags] = input_tags
  end

  def notebook=(input_notebook)
    self[:notebook] = input_notebook
  end

  def tags
    tags = self[:tags].split(' ,').to_a
  end
end
