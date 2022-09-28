def login
  visit new_session_url

  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'password'

  click_button 'Sign In'
end
