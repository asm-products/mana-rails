require 'rails_helper'

describe TeamsController, :type => :controller do
  before do
    login
    @team = Team.make
    @request.host = "www.example.com"
  end

  it 'it creates teams' do
    team = Team.make!(name:'TestTeam')
    post :create, team: {name: team.name}

    expect(response).to_not render_template :new
    expect(response).to render_template nil
  end

  it 'redirects to teams page' do
    post :create, team: {name: "testteam123"}

    expect(response).to redirect_to("http://testteam123.example.com" + edit_user_profile_path(current_user, current_user.profile))
  end

  it 'requires authentication' do
    logout if logged_in?
    get :new
    expect(response).to have_http_status 302
    expect(response).to redirect_to login_path
  end
end
