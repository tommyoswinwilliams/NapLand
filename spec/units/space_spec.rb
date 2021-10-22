require 'Space'

describe Space do

  # describe '.create' do

  #   it 'creates new space' do
  #     space = Space.create(name: 'My space', description: '2 bedrooms', price: 45, available: true)
  #     connection = PG.connect(dbname: "napland_test")

  #     result = connection.query("SELECT * FROM spaces WHERE id=#{space.id};")
      
  #     expect(result.first["name"]).to eq 'My space'
  #     expect(result.first["description"]).to eq '2 bedrooms'
  #     expect(result.first["price"]).to eq "45"
  #     expect(result.first["available"]).to eq "t"
  #   end
  # end

  describe '.all' do
    it 'shows all spaces' do
      # add the test data
      space = Space.create(name: 'My new space', description: '3 bedroom', price: 55, available_from: '2021-11-11', available_to: '2021-12-11')
      
      spaces = Space.all

      expect(spaces.length).to eq 1 
      expect(spaces.first).to be_a Space
      expect(spaces.first.id).to eq space.id
      expect(spaces.first.name).to eq space.name
      expect(spaces.first.description).to eq space.description
      expect(spaces.first.price).to eq space.price
      expect(spaces.first.available_from).to eq space.available_from
      expect(spaces.first.available_to).to eq space.available_to

    end
  end


  describe '.create' do

    it 'creates new space' do
      space = Space.create(name: 'My space', description: '2 bedrooms', price: 45, available_from: '2021-11-11', available_to: '2021-12-11')
      connection = PG.connect(dbname: "napland_test")

      result = connection.query("SELECT * FROM spaces WHERE id=#{space.id};")
      
      expect(result.first["name"]).to eq 'My space'
      expect(result.first["description"]).to eq '2 bedrooms'
      expect(result.first["price"]).to eq "45"
      expect(result.first["available_from"]).to eq '2021-11-11'
      expect(result.first["available_to"]).to eq '2021-12-11'
    end
  end

  describe ".find" do
    it "finds a space" do
      space = Space.create(name: 'My space', description: '2 bedrooms', price: 45, available_from: '2021-11-11', available_to: '2021-12-11')

      result = Space.find(id: space.id)

      expect(result.first.name).to eq space.name
      expect(result.first.description).to eq space.description
      expect(result.first.price).to eq space.price
      expect(result.first.available_from).to eq space.available_from
      expect(result.first.available_to).to eq space.available_to
    end
  end

end