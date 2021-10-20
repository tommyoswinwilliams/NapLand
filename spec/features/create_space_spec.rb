feature "Creating a space" do
  scenario "User creates a space" do
    visit '/spaces'
    fill_in :space_name, with: "My space"
    fill_in :space_description, with: "2 bedrooms"
    fill_in :space_price, with: 45
    fill_in :space_available, with: true
    click_button "Submit"

    expect(page).to have_content "Your space is saved!"

  end
end