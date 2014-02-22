require 'sequel'
Sequel::Model.db = Sequel.sqlite './database/db.sqlite'

class Note < Sequel::Model
  many_to_one :user

  def title=(input_title)
    self[:title] = input_title
  end

  def title
    title = self[:title]
  end

  def text=(input_text)
    self[:text] = input_text
  end

  def text
    text = self[:text]
  end

  def tags=(input_tags)
    self[:tags] = input_tags
  end

  def tags
    tags = self[:tags].split(' ,').to_a
  end

  def tags_list
    tags = self[:tags]
  end

  def notebook=(input_notebook)
    self[:notebook] = input_notebook
  end

  def notebook
    notebook = self[:notebook]
  end
end
