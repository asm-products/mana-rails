class Api::V1::IssuesController < ApplicationController
  before_action :set_project_issue, except: [:create]
  
  before_filter :authenticate_api

  # GET /projects/:project_id/issues
  # GET /projects/:project_id/issues.json
  def index
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
    @project = Project.find_by(id: params[:project_id]) || Project.find_by(short_code: params[:project_id])
    @issue = @project.issues.new(issue_params)
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
      @project = Project.find_by(id: params[:project_id]) || Project.find_by(short_code: params[:project_id])
      @issues = @project.issues.all
      @issue = @issues.find_by(unique_id: params[:id])
    end
    
    # allow issue parameters
    def issue_params
      params.permit(:subject, :description, :projected_hours, :due_date)
    end
end
