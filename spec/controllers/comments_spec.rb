require 'rails_helper'

describe CommentsController, :type => :controller do
  before do
    login
  end
  
  it "makes a new comment" do
    get :new
    expect(response).to render_template :new
  end  

  it "it creates a comment" do
    request.env["HTTP_REFERER"] = root_url
    
    comment = Comment.make
    post :create, comment: comment

    expect(response).to_not render_template :new
    expect(response).to redirect_to :back
  end

  it "requires authentication" do
    logout if logged_in?
    get :new
    expect(response).to have_http_status 302
  end
end
