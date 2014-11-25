class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit_profile, :update_profile]
  before_action :set_user_profile, only: [:show, :edit_profile, :update_profile]
  
  def show
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      UserProfile.create(user_id: @user.id)
      log_in @user
      flash[:success] = "Welcome to the Mana!"
      redirect_to edit_users_profile_path(@user.name)
    else
      render 'new'
    end
  end
    
  def edit_profile
    
  end
  
  def update_profile
    if @profile.update(user_profile_params)
      redirect_to @user
    else
      render 'edit_profile'
    end
  end
  
  private
    
    def set_user_profile
      @user = User.find_by(id: params[:id]) || User.find_by(name: params[:id])
      @profile = UserProfile.find_by(user_id: @user.id)
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def user_profile_params
      params.require(:user_profile).permit(:first_name, :last_name, :job_title, :phone)
    end
  
end
