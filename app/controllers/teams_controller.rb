class TeamsController < ApplicationController
  before_action :authenticate_user!

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)

    if @team.valid? and (current_user.teams << @team)
      flash[:success] = "Welcome to " + @team.name + ". Please check your email to verify your account."
      redirect_to edit_users_profile_path(current_user)
    else
      render 'new'
    end
  end

  def team_params
    params.require(:team).permit(:name)
  end
end

