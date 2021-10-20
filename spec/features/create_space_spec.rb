feature "Creating a space" do
  scenario "User creates a space" do
    fill_in :name, with: "My space"
    fill_in :description, with: "2 bedrooms"
    fill_in :price, with: 45
    fill_in :available, with: true

    expect(page).to have_content "My space"
    expect(page).to have_content "2 bedrooms"
    expect(page).to have_content 45
    expect(page).to have_content true
  end
end