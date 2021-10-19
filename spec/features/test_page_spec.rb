feature "Test Page" do
  scenario "visit test page" do
    visit "/test"
    expect(page).to have_content "Welcome to NapLand!"
  end
end