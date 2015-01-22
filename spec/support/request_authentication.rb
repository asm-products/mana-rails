module SpecAuthRequestHelper
  include Capybara::DSL

  def login(username='test@test.com', password='testtest')
    if User.count == 0
      user = User.make!
      user.teams << Team.make!
      user.user_profile = UserProfile.make!
      user.save!
    end
    visit login_path
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
    expect(page.current_path).not_to eq(login_path)
  end

  def signup(username, password)

  end
end
