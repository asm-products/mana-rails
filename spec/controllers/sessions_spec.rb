require 'rails_helper'

describe SessionsController, :type => :controller do

  it "should login at teams page" do
    user = User.make!
    team = user.teams.first
    @request.host = "#{team.slug}.example.com"
    post :create, session: {username: user.email, password: 'testtest'}
    expect(response).to redirect_to(user_url(user))
  end

  it "should not login at a other teams page" do
    user = User.make!
    team = Team.make!
    @request.host = "#{team.slug}.example.com"
    post :create, session: {username: user.email, password: 'testtest'}
    expect(response).to render_template(:new)
  end

  it "#new is 200" do
    get :new
    expect(response).to have_http_status 200
  end

  it "redirects to user after log in" do
    create_session
    expect(response).to have_http_status 200
  end

  it "logs out" do
    login
    delete :destroy, { id: current_user.id }
    expect(response).to redirect_to root_url
  end

  private
  def create_session
    @user = User.make
    post :create, session: {username: @user.email, password: 'testtest'}
  end
end
