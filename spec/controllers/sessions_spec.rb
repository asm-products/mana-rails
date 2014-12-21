require 'rails_helper'

describe SessionsController, :type => :controller do
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
