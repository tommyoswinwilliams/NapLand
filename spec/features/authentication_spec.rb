feature 'authentication' do
  scenario 'a user can sign in' do
    create_user_sign_in
    expect(page).to have_content 'Welcome, test@example.com'
  end

  scenario 'a user sees an error with wrong email' do
    sign_in_wrong_email
    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'Please check your email or password'
  end

  scenario 'a user sees an error with wrong password' do
    sign_in_wrong_password
    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'Please check your email or password'
  end

  scenario 'a user can sign out' do
    create_user_sign_in

    click_button('Sign out')

    expect(page).not_to have_content 'Welcome, test@example.com'
    expect(page).to have_content 'You have signed out.'
  end
end