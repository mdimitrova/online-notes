require 'sequel'
require 'bcrypt'

Sequel::Model.db = Sequel.sqlite './database/db.sqlite'

class User < Sequel::Model
  include BCrypt
  plugin :validation_helpers

  def password
    Password.new(self[:password])
  end

  def retype_password
    Password.new(self[:retype_password])
  end

  def username=(input_username)
    self[:username] = input_username
  end

  def email=(input_email)
    self[:email] = input_email
  end

  def password=(input_password)
    self[:password] = Password.create(input_password)
  end

  def retype_password=(input_retype_password)
    self[:retype_password] = Password.create(input_retype_password)
  end

  def validate
    super

    email_regex = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
    validates_presence [:username, :password, :email, :retype_password]
    validates_unique [:username, :password, :email]
    validates_format(email_regex, :email)
    validates_length_range(4...20, :username)
    validates_min_length(6, :password)

    if password != retype_password
      errors.add(:password, "Passwords must match")
    end
  end

  def self.authenticate(username, password)
    user = User.find(:username => username)
    return user if user and user.password == password
  end
end
