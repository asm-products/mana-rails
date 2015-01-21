require 'rails_helper'

describe UsersController, :type => :controller do
  describe "POST edit" do
    before do
      login
      current_user.permissions << Permission.make!(action: 'manage', klass: 'User')
    end

    let(:valid_attributes) { {id: current_user.id, user: {password: "abcd123123", password_confirmation: "abcd123123"}} }
    let(:invalid_attributes) { {id: current_user.id, user: {password: "1"}} }

    it "should save user password" do
      post :update, valid_attributes
      expect(current_user.reload.authenticate("abcd123123")).to eq(current_user)
    end

    it "should redirect to user path if saved" do
      post :update, valid_attributes
      expect(response).to redirect_to user_path(current_user)
    end

    it "should render edit if not saved" do
      post :update, invalid_attributes
      expect(response).to render_template(:edit)
    end

    it "should update user and not change password if none is given" do
      post :update, id: current_user.id, user: {email: "test@foo.com" }
      expect(response).to redirect_to user_path(current_user)
      expect(current_user.reload.authenticate("testtest")).to eq(current_user)
    end
  end
end
