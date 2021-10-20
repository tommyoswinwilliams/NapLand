feature "Viewing all listings" do
  scenario "a user can see all of the spaces" do
    visit '/spaces/all_listings'

    connection = PG.connect(dbname: "napland_test")
    connection.exec("INSERT INTO spaces(name, description, price, available) VALUES('My space', '2 bedrooms', 45, true);")

    expect(page).to have_content "My space"
    expect(page).to have_content "2 bedrooms"
    expect(page).to have_content 45
    expect(page).to have_content true
  end
end