require 'Space'

describe Space do

  describe '.create' do

    it 'creates new space' do
      space = Space.create(name: 'My space', description: '2 bedrooms', price: 45, available: true)
      connection = PG.connect(dbname: "napland_test")

      result = connection.query("SELECT * FROM spaces WHERE id=#{space.id};")
      
      expect(result.first["name"]).to eq 'My space'
      expect(result.first["description"]).to eq '2 bedrooms'
      expect(result.first["price"]).to eq 45
      expect(result.first["available"]).to eq true
    end
  end

  # describe '.all' do
  #   it 'shows all spaces' do
  #     connection = PG.connect(dbname: 'napland_test')

  #     connection.exec("INSERT INTO spaces (name, description, price, available) VALUES ('My space', '2 bedrooms', 45, true);")

  #     spaces = Spaces.
  # end

end