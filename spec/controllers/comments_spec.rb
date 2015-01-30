require 'rails_helper'

describe CommentsController, :type => :controller do
  before do
    login
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

  def invalid_attributes
    {
      subject: 'Test Comment',
      commenter: User.make!(email: "testcommenter@test.com",
                        name: "testcommenter1")
    }
  end

  describe "GET new comment" do
    it "assigns a new comment as @comment" do
      get :new, {:client_id => @client}
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new comment" do
        expect {
          post :create, {:comment => valid_attributes, :client_id => @client}
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment to @comment" do
        post :create, {:comment => valid_attributes, :client_id => @client}
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end

      it "assigns client id to @commentable" do
        post :create, {:comment => valid_attributes, :client_id => @client}
        expect(assigns(:commentable)).to be_a(Client)
        expect(assigns(:comment)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "does not ceate a new comment" do
        expect {
          post :create, {:comment => invalid_attributes, :client_id => @client}
        }.to_not change(Comment, :count)
      end
    end

  end

end
