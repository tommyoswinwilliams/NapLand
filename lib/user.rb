require 'pg'
require 'bcrypt'

class User
  def self.create(email:, password:)
    self.establish_connection

    encrypted_password = BCrypt::Password.create(password)
    result = connection.exec_params("INSERT INTO users (email, password) VALUES($1,$2) RETURNING id,email;", [email,encrypted_password])
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  def self.find(id)
    return nil unless id
    self.establish_connection

    result = connection.exec("SELECT * FROM users WHERE id = '#{id}'")
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  def self.authenticate(email:, password:)
    self.establish_connection

    result = connection.exec_params("SELECT * FROM users WHERE email = $1", [email])
    return nil unless result.any?
    return nil unless BCrypt::Password.new(result[0]['password']) == password
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  attr_reader :id, :email

  def initialize(id:, email:)
    @id = id
    @email = email
  end

  private

  def self.connection
    @@connection
  end

  def self.establish_connection
    if ENV['ENVIRONMENT'] == "test"
      @@connection = PG.connect(dbname: 'napland_test')
    else
      @@connection = PG.connect(dbname: 'napland')
    end
  end
end
