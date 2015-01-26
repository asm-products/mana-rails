require 'rails_helper'

RSpec.describe "Comments", :type => :request do
  
  before do
    @user = User.make!
    UserProfile.make!(:user => @user)
    sign_in_as_a_valid_user
    @client = Client.make!(name: 'A royal client', short_code: 'xxyyzz')
    request.env['HTTP_REFERER'] = '/clients'
  end


  def valid_attributes
    {
      subject: 'Test Comment',
      body: 'Test Body',
      commenter: User.make!(email: "testcommenter@test.com",
                        name: "testcommenter1")
    }
  end

  describe "GET Clients/:clientid" do
    it "should render the comment form" do
      get client_path(@client)
      response.body.should include("Create new client note...")
    end

    it "should render the created comment" do 
      @client.comments.create!(:body => 'thecomment is here', :commenter => @user)
      get client_path(@client)
      response.body.should include("thecomment is here")
    end
  end

  describe "POST Clients/:clientid/comments/new" do
    it "should create a new comment and render" do
      post_via_redirect client_comments_path(@client), :comment =>  valid_attributes
      get client_path(@client)
      response.body.should include("Test Body")
    end
  end
end
