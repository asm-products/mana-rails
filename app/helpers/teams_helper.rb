module TeamsHelper
  def current_team
    current_user.team if current_user
  end
end
