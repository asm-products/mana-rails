require 'rails_helper'

describe SessionsController, :type => :controller do
  it "#new is 200" do
    get :new
    expect(response).to have_http_status 200
  end

  it "it logs in" do
    login
    expect(logged_in?).to eq(true)
  end

  it "redirects to user after log in" do
    login
    expect(response).to redirect_to user_path current_user    
  end

  it "logs out" do
    login
    delete :destroy, { id: current_user.id }
    expect(response).to redirect_to root_url
  end
end
