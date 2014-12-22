class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.team.projects.paginate(page: params[:page])
  end

  def new
   @project = Project.new
  end
  
  def create
    @project = Project.new(project_params)
    @project.team = current_user.team
    @project.short_code = @project.generate_unique_short_code
    if @project.save
      flash[:success] = "Project Created!"
      redirect_to project_path(@project.short_code)
    else
      render 'new'
    end
  end
  
  def edit
    @project = Project.find_by_id(params[:id]) || Project.find_by_shortcode(params[:id])
    unless @project
      flash[:danger] = "There was an error finding your project. Please try again"
      redirect_to projects_url
    end
  end

  def show
    @project = Project.find_by_id(params[:id]) || Project.find_by_shortcode(params[:id])
  end
  
  def update
    @project = Project.find_by_id(params[:id]) || Project.find_by_shortcode(project_params[:short_code])
    if @project.update(project_params)
      redirect_to project_path(@project.short_code)
    else
      render 'edit'
    end
  end
  
  def destroy
    @project = Project.find_by_id(params[:id]) || Project.find_by_shortcode(project_params[:short_code])
    if @project.destroy
      flash[:success] = "Project Deleted!"
      redirect_to user_path(current_user)
    else
      render project_path(@project.id)
    end
  end
  
  private
  def project_params
    params.require(:project).permit(:name, :short_code, :client_id)
  end
end
