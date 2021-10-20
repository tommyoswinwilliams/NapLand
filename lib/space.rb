require "pg"

class Space
  attr_reader :id, :name, :description, :price, :available
  
  def initialize(id:, name:, description:, price:, available:)
    @id = id
    @name = name
    @description = description
    @price = price
    @available = available
  end

  def self.all
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: "napland_test")
    else
      connection = PG.connect(dbname: "napland")
    end
    result = connection.exec_params("SELECT * FROM spaces;")
    result.map do |item|
      Space.new(id: item["id"], name: item["name"], description: item["description"], price: item["price"], available: item["available"])
    end
  end

  def self.create(name:, description:, price:, available:)
    if ENV['ENVIRONMENT'] == "test"
      connection = PG.connect(dbname: "napland_test")
    else
      connection = PG.connect(dbname: "napland")
    end
    result = connection.exec_params("INSERT INTO spaces(name, description, price, available) VALUES ($1, $2, $3, $4) RETURNING id, name, description, price, available;", [name, description, price, available])
    Space.new(id: result[0]["id"], name: result[0]["name"], description: result[0]["description"], price: result[0]["price"], available: result[0]["available"])
  end
end