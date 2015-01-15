require "spec_helper"

describe ClientsController do
  context "logged in" do
    before(:each) do
      login
    end

    it "should create client" do
      visit clients_path
      click_link 'Create New Client'
      fill_in :client_name, with: "testname"
      fill_in :client_address, with: "testaddress"
      fill_in :client_phone, with: "123123"
      fill_in :client_website, with: "testweb.com"
      fill_in :client_short_code, with: "tscde"
      click_on "Create Client"

      expect(page.current_path).to eq(client_path('tscde'))
    end

    it "should list clients" do
      client = Client.make!
      visit clients_path

      expect(page).to have_content(client.name)
      expect(page).to have_content(client.address)
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
