module TeamsHelper
  def current_team
    current_user.teams.first if current_user
  end
end
