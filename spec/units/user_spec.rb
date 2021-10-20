require 'pg'

describe '.create' do
  it 'creates a new user' do
    user = User.create(email: 'test@example.com', password: 'password123')

    connection = PG.connect(dbname: 'napland_test')
    result = connection.exec("SELECT * FROM users;")
    expect(result.first['email']).to eq 'test@example.com'
  end
  it 'hashes the password using BPcrypt' do
    expect(BCrypt::Password).to receive(:create).with('password123')

    User.create(email: 'test@example.com', password: 'password123')
  end
end

describe '.find' do
  it 'retrieves a user from the database by id' do
    user = User.create(email: 'test@example.com', password: 'password123')
    result = User.find(user.id)

    expect(result.id).to eq user.id
    expect(result.email).to eq user.email
  end

  it 'returns nil if there is no user ID' do
    expect(User.find(nil)).to eq nil
  end
end
