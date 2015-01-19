require 'rails_helper'

describe ClientsController, :type => :controller do
  before do
    login
    @client = Client.make!(team_id: current_user.team_id)
  end

  context "with all permissions" do
    before do
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
      post :create, client: {name: "TestName2", short_code: "12346"}

      expect(response).to_not render_template :new
      expect(response).to render_template nil
    end

    it "should set team" do
      expect(current_user.team).to be_present
      post :create, client: {name: "testname", short_code: "12346"}
      expect(Client.last.team).to be_present
    end

    it "destroys Clients" do
      delete :destroy, { id: @client.short_code }
      expect(response).to redirect_to clients_path
    end

    it "requires authentication" do
      logout if logged_in?
      get :index
      expect(response).to have_http_status 302
    end
  end

  context "without permissions" do
    before { current_user.permissions.delete_all }

    it "should not be allowed to visit index" do
      get :index
      expect(response).to have_http_status 302
    end

    it "should not be allowed to visit new" do
      get :new
      expect(response).to have_http_status 302
    end

    it "should not be allowed to show " do
      get :show, { id: @client.id }
      expect(response).to have_http_status 302
    end

    it "should not be allowed to create" do
      post :create, client: {name: "testname", short_code: "12346"}
      expect(response).to have_http_status 302
    end

    it "should nto be allowed to delete" do
      delete :destroy, {id: @client.id}
      expect(response).to have_http_status 302
    end
  end

  context "with permissions from role" do
    before do
      role = Role.make!(name: 'user')
      role.permissions << Permission.make!(action: 'read', klass: 'Client')
      current_user.roles << role
    end

    it "should not be allowed to visit new" do
      get :new
      expect(response).to have_http_status 302
    end


    it "should not be allowed to create" do
      post :create, client: {name: "testname", short_code: "12346"}
      expect(response).to have_http_status 302
    end

    it "should nto be allowed to delete" do
      delete :destroy, {id: @client.id}
      expect(response).to have_http_status 302
    end

    it "shows clients" do
      get :show, { id: @client.short_code }
      expect(response).to render_template :show
      expect(response).to_not have_http_status 404
    end

    it "lists clients" do
      get :index
      expect(response).to render_template :index
    end
  end
end
