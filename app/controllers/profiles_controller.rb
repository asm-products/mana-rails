class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_user
  before_filter :set_profile, except: [:new, :create]
  load_and_authorize_resource

  def show
  end

  def new
    @profile = @user.profile.new
  end

  def create
    @profile = @user.profile.new(profile_params)
    if @profile.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
    def profile_params
      params.require(:user_profile).permit(:first_name, :last_name, :job_title, :phone)
    end

    def set_user
      @user = User.find_by(id: params[:id]) || User.find_by(name: params[:id])
    end

    def set_profile
      @profile = @user.profile
    end
end
