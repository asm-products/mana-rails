require 'rails_helper'

describe ClientsController, :type => :controller do
  before do
    login
    @client = Client.make!(team_id: current_user.team_id)
    current_user.permissions << Permission.make!(action: 'manage', klass: 'Client')
  end

  it "lists clients" do
    get :index
    expect(response).to render_template :index
  end

  it "shows clients" do
    get :show, { id: @client.short_code }
    expect(response).to render_template :show
    expect(response).to_not have_http_status 404
  end

  it "it creates clients" do
    client = Client.make!(name: "TestName2", short_code: "12346")
    post :create, client: {name: client.name}

    expect(response).to_not render_template :new
    expect(response).to render_template nil
  end

  it "should set team" do
    expect(current_user.team).to be_present
    post :create, client: {name: "testname", short_code: "12346"}
    expect(Client.last.team).to be_present
  end

  it "destroys Clients" do
    client = Client.create
    delete :destroy, { id: @client.short_code }
    expect(response).to redirect_to clients_path
  end

  it "requires authentication" do
    logout if logged_in?
    get :index
    expect(response).to have_http_status 302
  end
end
