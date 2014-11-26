require 'rails_helper'

describe HomeController, :type => :controller do
  it "#index is 200" do
    get :index
    expect(response).to have_http_status 200
  end
end
