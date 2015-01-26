module UserRequestHelper

  def sign_in_as_a_valid_user
    @user ||= User.make!
    post_via_redirect login_path, 'session' => {:username => @user.email, :password => @user.password }
  end
end
