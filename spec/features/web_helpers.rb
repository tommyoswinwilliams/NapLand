def create_user_sign_in
  User.create(email: 'test@example.com', password: 'password123')

  visit '/sessions/new'
  fill_in(:email, with: 'test@example.com')
  fill_in(:password, with: 'password123')
  click_button('Sign in')
end

def sign_in_wrong_email
  User.create(email: 'test@example.com', password: 'password123')

  visit '/sessions/new'
  fill_in(:email, with: 'nottherightemail@example.com')
  fill_in(:password, with: 'password123')
  click_button('Sign in')
end

def sign_in_wrong_password
  User.create(email: 'test@example.com', password: 'password123')

  visit '/sessions/new'
  fill_in(:email, with: 'test@example.com')
  fill_in(:password, with: 'wrongpassword')
  click_button('Sign in')
end