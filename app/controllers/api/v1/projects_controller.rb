class Api::V1::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]
  
  before_filter :authenticate_api

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    render json: @projects
  end
  
  # GET /projects/:id
  # GET /projects/:id.json
  def show
    if !@project.nil?
      render json: @project
    else
      render json: {message: 'Project not found'}, status: :not_found
    end
  end
  
  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    if @project.save
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /projects/:id
  # PATCH/PUT /projects/:id.json
  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity  
    end
  end
  
  #DELETE /projects/:id
  #DELETE /projects/:id.json
  def destroy
    @project.destroy
    render json: @project
  end
  
  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.where("id = :id OR short_code = :id", {id: params[:id]}).take
    end
    
    # allow project paramaters
    def project_params
      params.permit(:name, :short_code, :description, :due_date, :client_id)
    end

end
