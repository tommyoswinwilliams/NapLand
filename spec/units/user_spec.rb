require 'pg'

describe '.create' do
  it 'creates a new user' do
    user = User.create(email: 'test@example.com', password: 'password123')

    connection = PG.connect(dbname: 'napland_test')
    result = connection.query("SELECT * FROM users;")
    expect(user.email).to eq 'test@example.com'
  end
end
