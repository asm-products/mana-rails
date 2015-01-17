class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit_profile, :update_profile]
  before_filter :set_user_profile, only: [:show, :edit_profile, :update_profile]
  load_and_authorize_resource

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params, special_key: SecureRandom.base64.tr('+/=', 'Qrt'))
    if @user.save
      UserProfile.create(user_id: @user.id)
      log_in @user
      UserMailer.verify_email(@user).deliver
      redirect_to new_team_path
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

  def verify
    @allow_verify = true
    @user = User.find_by(special_key: params[:id])
    if @user.updated_at > DateTime.now - 24.hours
      @user.update(verified: true, special_key: nil)
      flash[:success] = "Your email address has been verified."
      redirect_to @user
    else
      @allow_verify = false
    end
  end

  def reverify
    @user = User.find_by(special_key: params[:id])
    @user.update_attribute(:special_key, SecureRandom.base64.tr('+/=', 'Qrt'))
    UserMailer.verify_email(@user).deliver
    flash[:success] = "Please check your email to verify your account"
    redirect_to root_path
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
