require "rails_helper"

describe UsersController do
  before(:each) do
    Permission.seed
  end

  it "should signup new users" do
    Capybara.app_host = "http://www.example.com"
    visit '/'
    click_on 'Register'

    fill_in :user_name, with: 'testuser'
    fill_in :user_email, with: 'testemail@domain.com'
    fill_in :user_password, with: 'password'
    fill_in :user_password_confirmation, with: 'password'
    click_on 'Create my account'

    expect(page.current_path).to eq(new_team_path)

    fill_in :team_name, with: 'testteam'
    click_on 'Create team'

    login('testemail@domain.com', 'password', 'testteam')

    # expect(page).to have_content("Please check your email to verify your account.")
    # expect(page).to have_content("Welcome to Mana, tell us a little about you")
  end

  it "should edit profile with permission" do
    login
    Membership.last.permissions << Permission.all

    visit '/'
    click_on 'Profile'
    click_on 'Edit Profile'

    fill_in :user_profile_first_name, with: 'my first name'
    fill_in :user_profile_last_name, with: 'my last name'
    fill_in :user_profile_job_title, with: 'my job title'
    fill_in :user_profile_phone, with: '123123'
    click_on 'Update User profile'
  end

  it "should change password" do
    login
    user = User.last
    Membership.last.permissions << Permission.all

    visit '/'
    click_on 'Profile'
    click_on 'Edit User'

    fill_in :user_password, with: 'test12345'
    fill_in :user_password_confirmation, with: 'test12345'
    click_on 'Update my Account'

    expect(page.current_path).to eq(user_path(user))

    user.reload
    expect(user.authenticate('test12345')).to eq(user)
  end
end
