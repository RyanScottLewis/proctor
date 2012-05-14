class ProjectsController < ApplicationController
  respond_to :json
  
  # GET /projects.json
  def index
    @projects = params[:project].blank? ? Project.all : Project.where(params[:project])
    
    respond_with @projects
  rescue => e
    Rails.logger.error e
    render :text => 'Invalid params.', :status => :bad_request
  end
  
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    
    respond_with @project
  rescue => e
    Rails.logger.error e
    render :text => 'Invalid params.', :status => :bad_request
  end
  
  # POST /projects.json
  def create
    @project = Project.create(params[:project])
    
    respond_with @project
  rescue => e
    Rails.logger.error e
    render :text => 'Invalid params.', :status => :bad_request
  end
  
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])
    @project.update_attributes(params[:project])
    
    respond_with @project
  rescue => e
    Rails.logger.error e
    render :text => 'Invalid params.', :status => :bad_request
  end
  
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    
    head :ok
  rescue => e
    Rails.logger.error e
    head :not_found
  end
end
