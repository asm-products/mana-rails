class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    render json: @users, except: [:password_digest, :remember_digest]
  end
  
  # GET /users/:id
  # GET /users/:id.json
  def show
    if !@user.nil?
      render json: @user, except: [:password_digest, :remember_digest]
    else
      render json: {message: 'User not found'}, status: :not_found
    end
  end
  
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, except: [:password_digest, :remember_digest]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /users/:id
  # PATCH/PUT /users/:id.json
  def update
    if @user.update(user_params)
      render json: @user, except: [:password_digest, :remember_digest]
    else
      render json: @user.errors, status: :unprocessable_entity
    end    
  end
  
  # DELETE /users/:id
  # DELETE /users/:id.json
  def destroy
    @user.destroy
    render json: @user, except: [:password_digest, :remember_digest]
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.where("id = :id OR name = :id", {id: params[:id]}).take
    end
    
    #allow user parameters
    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
  
end
