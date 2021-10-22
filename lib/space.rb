require "pg"

class Space
  attr_reader :id, :name, :description, :price, :available_from, :available_to
  
  def initialize(id:, name:, description:, price:, available_from:, available_to:)
    @id = id
    @name = name
    @description = description
    @price = price
    @available_from = available_from
    @available_to = available_to

  end

  def self.all
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: "napland_test")
    else
      connection = PG.connect(dbname: "napland")
    end
    result = connection.exec_params("SELECT * FROM spaces;")
    result.map do |item|
      Space.new(id: item["id"], name: item["name"], description: item["description"], price: item["price"], available_from: item["available_from"], available_to: item["available_to"])
    end
  end

  # def self.create(name:, description:, price:, available:)
  #   if ENV['ENVIRONMENT'] == "test"
  #     connection = PG.connect(dbname: "napland_test")
  #   else
  #     connection = PG.connect(dbname: "napland")
  #   end
  #   result = connection.exec_params("INSERT INTO spaces(name, description, price, available) VALUES ($1, $2, $3, $4) RETURNING id, name, description, price, available;", [name, description, price, available])
  #   Space.new(id: result[0]["id"], name: result[0]["name"], description: result[0]["description"], price: result[0]["price"], available: result[0]["available"])
  # end

  def self.create(name:, description:, price:, available_from:, available_to:)
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: "napland_test")
    else
      connection = PG.connect(dbname: "napland")
    end
    result = connection.exec("INSERT INTO spaces(name, description, price, available_from, available_to) VALUES ($1, $2, $3, $4, $5) RETURNING id, name, description, price, available_from, available_to;", [name, description, price, available_from, available_to])
    Space.new(id: result[0]["id"], name: result[0]["name"], description: result[0]["description"], price: result[0]["price"], available_from: result[0]["available_from"], available_to: result[0]["available_to"])
  end

  def self.find(id:)
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: "napland_test")
    else
      connection = PG.connect(dbname: "napland")
    end
    result = connection.exec_params("SELECT * FROM spaces WHERE id=#{id};")
    Space.new(id: result[0]["id"], name: result[0]["name"], description: result[0]["description"], price: result[0]["price"], available_from: result[0]["available_from"], available_to: result[0]["available_to"])
  end
end