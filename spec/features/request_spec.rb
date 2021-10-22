feature "request button" do
  scenario 'Users can send request to book a space' do
    visit '/spaces'
    click_link "space.id"

    expect(page).to expect(page).to have_selector(:link_or_button, “Request space”)
  end
end