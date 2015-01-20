require 'rails_helper'

describe UsersController, :type => :controller do
  describe "POST edit" do
    before do
      login
      current_user.permissions << Permission.make!(action: 'manage', klass: 'User')
    end

    it "should save user password" do
      post :update, {id: current_user.id, user: {password: "abcd123123", password_confirmation: "abcd123123"}}
      expect current_user.reload.authenticate("abcd123123")
    end

    it "should not change password, if non is given" do
      post :update, {id: current_user.id, user: {}}
      expect(response).to redirect_to user_path(current_user)
    end

    it "should render edit if not saved" do
      expect(User).to receive(:save).and_return(false)
      post :update, {id: current_user.id, user: {}}
      expect(response).to render_template(:new)
    end
  end
end
