feature "Viewing available listings" do
  
  scenario "a user can see available spaces given a date" do
    visit '/spaces'
    fill_in :date_from, with: '2021-06-11'
    fill_in :date_to, with: '2021-06-15'
    click_button "See Available Spaces"

    expect(page).not_to have_content '2021-11-11'
    expect(page).not_to have_content '2021-11-11'
  end
end