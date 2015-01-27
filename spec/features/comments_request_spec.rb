require 'rails_helper'

describe CommentsController do
  
  before do
    @client = Client.make!(name: 'A royal client', short_code: 'xxyyzz')
  end

  context "permission to read" do
    before(:each) do
      login
      Permission.seed "Client"
    end

    it "should not see create comment button" do
      visit client_path(@client)
      print page.html
      expect(page).to_not have_content("Create new comment...")
      expect(page).to have_content("You are not authorized to access this page.")
    end
  end

  context "permission to manage" do
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

    def create_comment
      create_client
      fill_in :comment_body , with: "testcomment"
      click_on "Create Comment"
    end

    it "should render comment form" do
      create_client 
      page.should have_selector(:link_or_button, 'Create Comment')
    end

    it "should create new comment and render it" do
      create_comment
      page.should have_content("Comment Saved!")
      page.should have_content("testcomment")
    end
  end

end
