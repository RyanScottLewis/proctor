class IterationsController < ApplicationController
  respond_to :json
  
  # GET /iterations.json
  def index
    @iterations = Iteration.all
    
    respond_with @iterations
  end
  
  # GET /iterations/1.json
  def show
    begin
      @iteration = Iteration.find(params[:id])
      
      respond_with @iteration
    rescue => e
      Rails.logger.error e
      render :text => 'Invalid params.', :status => :bad_request
    end
  end
  
  # POST /iterations.json
  def create
    begin
      @iteration = Iteration.create( params[:iteration] )
      
      respond_with @iteration
    rescue => e
      Rails.logger.error e
      render :text => 'Invalid params.', :status => :bad_request
    end
  end
  
  # DELETE /iterations/1.json
  def destroy
    begin
      @iteration = Iteration.find(params[:id])
      @iteration.destroy
      
      head :ok
    rescue => e
      Rails.logger.error e
      head :not_found
    end
  end
end
