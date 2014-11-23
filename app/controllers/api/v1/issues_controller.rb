class Api::V1::IssuesController < ApplicationController
  before_action :set_project_issue, only: [:index, :show, :update, :destroy]
  
  before_filter :authenticate_api

  # GET /projects/:project_id/issues
  # GET /projects/:project_id/issues.json
  def index
    @issues = Issue.where(project_id: @project.id)
    render json: @issues
  end
  
  # GET /projects/:project_id/issues/:id
  # GET /projects/:project_id/issues/:id.json
  def show
    if !@issue.nil?
      render json: @issue
    else
      render json: {message: 'Issue not found'}, status: :not_found
    end
  end
  
  # POST /projects/:project_id/issues
  # POST /projects/:project_id/issues.json
  def create
    @project = Project.where("id = :project_id OR short_code = :project_id", {project_id: params[:project_id]}).take
    @issue = Issue.new(issue_params)
    @issue.project_id = @project.id
    @issue.unique_id = get_next_issue_id(@project.id)
    if @issue.save
      @project.update_attribute(:projected_hours, get_projected_hours(@project.id))
      render json: @issue
    else
      render json: @issue.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /projects/:project_id/issues/:id
  # PATCH/PUT /projects/:project_id/issues/:id.json
  def update
    if @issue.update(issue_params)
      render json: @issue
    else
      render json: @issue.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /projects/:project_id/issues/:id
  # DELETE /projects/:project_id/issues/:id.json
  def destroy
    @issue.destroy
    render json: @issue
  end
  
  
  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_project_issue
      @project = Project.where("id = :project_id OR short_code = :project_id", {project_id: params[:project_id]}).take
      @issue = Issue.where("project_id = :project_id AND unique_id = :id", {project_id: @project.id, id: params[:id]}).take
    end
    
    # allow issue parameters
    def issue_params
      params.permit(:subject, :description, :projected_hours, :due_date)
    end
    
    # update projected hours for issue project
    def get_projected_hours(project_id)
      collection = Issue.where(project_id: project_id)
      sum_hours = 0
      collection.each do |i|
        sum_hours = sum_hours + i.projected_hours
      end
      return sum_hours
    end
    
    # get the issues unique_id
    def get_next_issue_id(project_id)
      i = 0
      if Issue.where(project_id: project_id).count == 0
        i = 1
      else
        last_issue = Issue.where(project_id: project_id).order(:unique_id).last
        i = last_issue.unique_id + 1
      end
      return i
    end
end
