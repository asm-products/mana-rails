class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_filter :set_user, only: [:show, :edit, :update]
  load_and_authorize_resource

  def show
    @profile = @user.profile
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      redirect_to user_path(@user), notice: "Updated User Account"
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params, special_key: SecureRandom.base64.tr('+/=', 'Qrt'))
    if @user.save
      Profile.create(user_id: @user.id)
      log_in @user
      UserMailer.verify_email(@user).deliver
      redirect_to new_team_path
    else
      render 'new'
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

    def set_user
      @user = User.find_by(id: params[:id]) || User.find_by(name: params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
