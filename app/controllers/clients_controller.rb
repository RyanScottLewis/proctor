class ClientsController < ApplicationController
  respond_to :json
  
  # GET /clients.json
  def index
    @clients = params[:client].blank? ? Client.all : Client.where(params[:client])
    
    respond_with @clients
  rescue => e
    Rails.logger.error e
    render :text => 'Invalid params.', :status => :bad_request
  end
  
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])
    
    respond_with @client
  rescue => e
    Rails.logger.error e
    render :text => 'Invalid params.', :status => :bad_request
  end
  
  # POST /clients.json
  def create
    @client = Client.create(params[:client])
    
    respond_with @client
  rescue => e
    Rails.logger.error e
    render :text => 'Invalid params.', :status => :bad_request
  end
  
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])
    @client.update_attributes(params[:client])
    
    respond_with @client
  rescue => e
    Rails.logger.error e
    render :text => 'Invalid params.', :status => :bad_request
  end
  
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    
    head :ok
  rescue => e
    Rails.logger.error e
    head :not_found
  end
end
