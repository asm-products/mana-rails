require 'rails_helper'

describe ProfilesController, :type => :controller do
  before do
    login
    @request.host = "#{current_team.slug}.example.com"
    current_user.current_membership.permissions << Permission.make!(action: 'manage', klass: 'User')
    @profile = current_user.profile
  end

  it "shows user profile" do
    get :show, { id: @profile.id }
    expect(response).to render_template :show
    expect(response).to_not have_http_status 404
  end
end
