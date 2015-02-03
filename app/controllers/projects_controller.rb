class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_project, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @projects = @projects.order('name ASC').paginate(:page => params[:page])
  end

  def new
  end

  def create
    @project.team = current_team
    @project.short_code = @project.generate_unique_short_code
    if @project.save
      flash[:success] = "Project Created!"
      redirect_to project_path(@project.short_code)
    else
      render 'new'
    end
  end

  def edit
    unless @project
      flash[:danger] = "There was an error finding your project. Please try again"
      redirect_to projects_url
    end
  end

  def show
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project.short_code)
    else
      render 'edit'
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = "Project Deleted!"
      redirect_to user_path(current_user)
    else
      render project_path(@project.id)
    end
  end

  private
  def set_project
    @project = Project.find_by_id(params[:id]) || Project.find_by_shortcode(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :short_code, :client_id)
  end
end
