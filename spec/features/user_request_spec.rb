require "rails_helper"

describe UsersController do
  before(:each) do
    Permission.seed "User"
  end

  it "should signup new users" do
    visit '/'
    click_on 'Register'

    fill_in :user_name, with: 'testuser'
    fill_in :user_email, with: 'testemail@domain.com'
    fill_in :user_password, with: 'password'
    fill_in :user_password_confirmation, with: 'password'
    click_on 'Create my account'

    expect(page.current_path).to eq(new_team_path)
    User.last.permissions << Permission.all

    fill_in :team_name, with: 'testteam'
    click_on 'Create team'

    expect(page).to have_content("Please check your email to verify your account.")
    expect(page).to have_content("Welcome to Mana, tell us a little about you")
  end

  it "should edit profile" do
    login
    User.last.permissions << Permission.all

    visit '/'
    click_on 'Profile'
    click_on 'Edit Profile'

    fill_in :user_profile_first_name, with: 'my first name'
    fill_in :user_profile_last_name, with: 'my last name'
    fill_in :user_profile_job_title, with: 'my job title'
    fill_in :user_profile_phone, with: '123123'
    click_on 'Update User profile'
  end
end
