module TeamsHelper
  def current_team
    current_user.team
  end
end
