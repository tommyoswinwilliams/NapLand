require 'Spaces'

describe Spaces do

  describe '.create' do
    it 'creates new space' do
      space = Space.create(name: 'My space', description: '2 bedrooms', price: 45, available: true)

      expect(spaces['name']).to eq 'My space'
      expect(spaces['description']).to eq '2 bedrooms'
      expect(spaces['price']).to eq 45
      expect(spaces['available']).to eq true
    end
  end

  # describe '.all' do
  #   it 'shows all spaces' do
  #     connection = PG.connect(dbname: 'napland_test')

  #     connection.exec("INSERT INTO spaces (name, description, price, available) VALUES ('My space', '2 bedrooms', 45, true);")

  #     spaces = Spaces.
  # end

end