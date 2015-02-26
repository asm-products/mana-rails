require 'rails_helper'

describe ProfilesController, :type => :controller do
  before do
    login
    @request.host = "#{current_team.slug}.example.com"
    current_user.current_membership.permissions << Permission.make!(action: 'manage', klass: 'Profile')
    @profile = current_user.profile
  end

  it "shows user profile" do
    pending "profile is displayed in user view"
    get :show, { user_id: current_user.to_param, id: @profile.to_param }
    expect(response).to render_template :show
    expect(response).to_not have_http_status 404
  end
end
