class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Session
  before_filter :set_team

  def set_team
    if current_user
      current_user.current_team = current_team
      current_user.current_membership = current_user.memberships.find_by(team: current_team)
    end
  end

  # Handle Access Denied Exceptions
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
