class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: username) || User.find_by(email: username)
    if user && user.authenticate(password) && current_team.users.include?(user)
      log_in user
      remember_me == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def username
    session_params[:username].downcase
  end

  def password
    session_params[:password]
  end

  def remember_me
    session_params[:remember_me]
  end

  def session_params
    params[:session]
  end

end
