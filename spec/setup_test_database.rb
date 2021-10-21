def setup_test_database
  connection = PG.connect(dbname: 'napland_test')

  # Clean the users table
  connection.exec("TRUNCATE users;")
end