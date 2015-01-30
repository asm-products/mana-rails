module SpecAuthHelper
  def login(user=nil)
    begin
      user = User.make!
      user.teams << Team.make!
      user.save
    rescue
    end
    session[:user_id] = user.id
  end

  def current_user
    @current_user || @current_user = User.find(session[:user_id])
  end

  def current_team
    @current_team || @current_team = @current_user.teams.first
  end


  def logged_in?
    true if current_user
  end

  def logout
    @current_user = nil
    session[:user_id] = nil
  end
end
