require 'sequel'
require 'bcrypt'

Sequel::Model.db = Sequel.sqlite './database/db.sqlite'

class User < Sequel::Model
  include BCrypt
  plugin :validation_helpers

  def password
    Password.new(self[:password])
  end

  def password=(new_password)
    self[:password] = Password.create(new_password)
  end

  def username=(new_username)
    self[:username] = new_username
  end

  def email=(new_email)
    self[:email] = new_email
  end

  def retypePassword=(new_retypePassword)
    self[:retypePassword] = new_retypePassword
  end

  #TODO SEND MAIL

  def validate_data
    super

    validates_presence [:username, :password, :email, :retypePassword]
    validates_unique [:username, :password]
    validates_format(email_regex, :email)
    validates_length_range(4...20, :username)
    validates_min_length(6, :password)

    email_regex = '/\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/'
  end

  def self.authenticate(username, password)
    user = User.find(:username => username)
    return user if user.password == password
  end
end
