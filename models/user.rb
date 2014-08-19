require 'sequel'
require 'bcrypt'

Sequel::Model.db = Sequel.sqlite './database/db.sqlite'

class User < Sequel::Model
  include BCrypt
  plugin :validation_helpers

  attr_accessor :password
  attr_accessor :password_confirmation
  attr_reader   :crypted_password

  def username=(input_username)
    self[:username] = input_username
  end

  def email=(input_email)
    self[:email] = input_email
  end

  def password=(input_password)
    @password = input_password
    self[:crypted_password] = Password.create(input_password)
  end

  def password_confirmation=(input_password_confirmation)
    @password_confirmation = input_password_confirmation
  end

  def validate
    super

    email_regex = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
    validates_presence [:username, :email, :password, :password_confirmation]
    validates_unique [:username, :email]
    validates_format(email_regex, :email)
    validates_length_range(4...20, :username)
    validates_min_length(6, :password)

    if password != password_confirmation
      errors.add(:password, "Passwords must match")
    end
  end

  def self.authenticate(username, password)
    user = User.find(:username => username)
    return user if user and user.crypted_password == Password.create(password)
  end
end
