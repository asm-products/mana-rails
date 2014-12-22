class TeamsController < ApplicationController
  before_action :authenticate_user!

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)

    if @team.valid? and current_user.update_attribute(:team_id, @team.id)
      flash[:success] = "Team Created!"
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def team_params
    params.require(:team).permit(:name)
  end
end

