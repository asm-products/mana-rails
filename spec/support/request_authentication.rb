module SpecAuthRequestHelper
  include Capybara::DSL

  def login(username='test@test.com', password='testtest', slug=nil)
    if User.count == 0
      user = User.make!
      team = Team.make!
      user.teams << team
      slug = team.slug
      user.profile = Profile.make!
      user.save!
    end
    Capybara.app_host = "http://#{slug}.example.com"
    visit login_path
    fill_in 'session_username', with: username
    fill_in 'session_password', with: password
    click_button 'Log in'
    expect(page.current_path).not_to eq(login_path)
  end

  def signup(username, password)

  end
end
