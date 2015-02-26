class TeamsController < ApplicationController
  before_action :authenticate_user!

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)

    if @team.valid? and (current_user.teams << @team)
      flash[:success] = "Welcome to " + @team.name + ". Please check your email to verify your account."
      redirect_to edit_user_profile_url(current_user, current_user.profile, subdomain: @team.slug)
    else
      render 'new'
    end
  end

  def team_params
    params.require(:team).permit(:name)
  end
end

