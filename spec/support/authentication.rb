module SpecAuthHelper
  def login(user=nil)
    user = User.make!
    @team = Team.make!
    user.teams << @team
    user.save
    @request.host = "#{@team.slug}.example.com"
    session[:user_id] = user.id
  end

  def current_user
    @current_user || @current_user = User.find(session[:user_id])
  end

  def current_team
    @team
  end

  def logged_in?
    true if current_user
  end

  def logout
    @current_user = nil
    session[:user_id] = nil
  end
end
