require 'rails_helper'

describe TeamsController, :type => :controller do
  before do
    login
    @team = Team.make!
  end

  it 'it creates teams' do
    team = Team.make!(name:'TestTeam')
    post :create, team: {name: team.name}

    expect(response).to_not render_template :new
    expect(response).to render_template nil
  end

  it 'requires authentication' do
    logout if logged_in?
    get :new
    expect(response).to have_http_status 302
  end
end