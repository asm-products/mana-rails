module SpecAuthHelper
  def login(user=nil)
    user = User.make!
    post :create, session: {username: user.email, password: 'testtest' }
  end

  def current_user
    @current_user || @current_user = User.find(session[:user_id])
  end

  def logged_in?
    true if current_user
  end

  def logout
    @current_user = nil
    session[:user_id] = nil
  end
end
