feature "Viewing all listings" do
  scenario "a user can see all of the spaces" do
    visit '/spaces/new'
    fill_in :space_name, with: "My space"
    fill_in :space_description, with: "2 bedrooms"
    fill_in :space_price, with: 45
    fill_in :space_available_from, with: '2021-11-11'
    fill_in :space_available_to, with: '2021-12-11'
    click_button "Submit"

    click_button "Show All Listings"

    expect(page).to have_content "My space"
    expect(page).to have_content "2 bedrooms"
    expect(page).to have_content 45
    expect(page).to have_content '2021-11-11'
    expect(page).to have_content '2021-11-11'
  end
end