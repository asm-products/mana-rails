require 'rails_helper'

describe ClientsController, :type => :controller do
  before do
    login
    @client = Client.make!
  end

  it "#index is 200" do
    get :index
    expect(response).to have_http_status 200
  end

  it "it creates clients" do
    client = Client.create
    expect(response).to have_http_status 200
  end

  it "destroys Clients" do
    client = Client.create
    delete :destroy, { id: @client.id }
    expect(response).to redirect_to clients_path
  end
end
