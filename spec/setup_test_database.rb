require 'pg'

def setup_test_database
  p "Setting up test database..."

  connection = PG.connect(dbname: 'napland_test')

  connection.exec("TRUNCATE spaces;")
  connection.exec("TRUNCATE users;")
end