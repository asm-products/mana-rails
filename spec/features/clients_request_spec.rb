require "rails_helper"

describe ClientsController do
  context "logged in" do
    before(:each) do
      login
      Permission.seed "Client"
      User.last.permissions << Permission.all
    end

    def create_client
      visit clients_path
      click_link 'Create New Client'
      fill_in :client_name, with: "testname"
      fill_in :client_address, with: "testaddress"
      fill_in :client_phone, with: "123123"
      fill_in :client_website, with: "testweb.com"
      fill_in :client_short_code, with: "tscde"
      click_on "Create Client"
      expect(Client.last.team).to be_present
    end

    it "should create client" do
      create_client
      expect(page.current_path).to eq(client_path('tscde'))
    end

    it "should list clients" do
      create_client
      visit clients_path

      expect(page).to have_content("testname")
      expect(page).to have_content("testaddress")
    end

    it "should not be allowed to edit other teams clients" do
      team = Team.make!
      client = Client.make!
      team.clients << client
      visit edit_client_path(client)
      expect(page).to have_content("You are not authorized to access this page.")
    end
  end

  context "not logged in" do
    it "should not see clients list" do
      visit clients_path
      expect(page.current_path).to eq(login_path)
    end

    it "should not see client" do
      visit client_path(Client.make!)
      expect(page.current_path).to eq(login_path)
    end
  end
end
