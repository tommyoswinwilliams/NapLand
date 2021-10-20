require 'bcrypt'

class User
  def self.create(email:, password:)
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: 'napland_test')
    else
      connection = PG.connect(dbname: 'napland')
    end

    encrypted_password = BCrypt::Password.create(password)
    result = connection.exec_params("INSERT INTO users (email, password) VALUES($1,$2) RETURNING id,email;", [email,encrypted_password])
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  def self.find(id)
    return nil unless id
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: 'napland_test')
    else
      connection = PG.connect(dbname: 'napland')
    end

    result = connection.exec("SELECT * FROM users WHERE id = '#{id}'")
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  def self.authenticate(email:, password:)
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: 'napland_test')
    else
      connection = PG.connect(dbname: 'napland')
    end

    result = connection.exec_params("SELECT * FROM users WHERE email = $1", [email])
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

  attr_reader :id, :email

  def initialize(id:, email:)
    @id = id
    @email = email
  end
end
