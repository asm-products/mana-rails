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
    client = Client.make!(name: "TestName2", short_code: "12346")
    post :create, client: {name: client.name}

    expect(response).to_not render_template :new
    expect(response).to render_template nil
  end

  it "destroys Clients" do
    client = Client.create
    delete :destroy, { id: @client.id }
    expect(response).to redirect_to clients_path
  end
end
