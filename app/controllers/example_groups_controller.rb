class ExampleGroupsController < ApplicationController
  respond_to :json
  
  # GET /example_groups.json
  def index
    @example_groups = ExampleGroup.all
    
    respond_with @example_groups
  end
  
  # GET /example_groups/1.json
  def show
    begin
      @example_group = ExampleGroup.find(params[:id])
      
      respond_with @example_group
    rescue => e
      Rails.logger.error e
      render :text => 'Invalid params.', :status => :bad_request
    end
  end
  
  # POST /example_groups.json
  def create
    begin
      raise unless params.has_key?(:example_group)
      
      @example_group = if params[:example_group].has_key?(:iteration_id) && !params[:example_group][:iteration_id].nil?
        iteration_id = params[:example_group].delete(:iteration_id)
        
        Iteration.find(iteration_id).example_groups.create( params[:example_group] )
      elsif params[:example_group].has_key?(:example_group_id) && !params[:example_group][:example_group_id].nil?
        example_group_id = params[:example_group].delete(:example_group_id)
        
        # parent_example_group = ExampleGroup.find(example_group_id)
        # example_group = parent_example_group.example_groups.create( params[:example_group] )
        # parent_example_group.save
        # 
        # example_group
        
        ExampleGroup.find(example_group_id).example_groups.create( params[:example_group] )
      else
        ExampleGroup.create( params[:example_group] )
      end
      
      # @example_group = ExampleGroup.create( params[:example_group] )
      
      respond_with @example_group
    rescue => e
      Rails.logger.error e
      render :text => 'Invalid params.', :status => :bad_request
    end
  end
  
  # PUT /example_groups/1.json
  def update
    begin
      raise unless params.has_key?(:example_group)
      
      @example_group = ExampleGroup.find( params[:id] )
      @example_group.update_attributes( params[:example_group] )
      
      respond_with @example_group
    rescue => e
      Rails.logger.error e 
      render :text => 'Invalid params.', :status => :bad_request
    end
  end
  
  # DELETE /example_groups/1.json
  def destroy
    begin
      @example_group = ExampleGroup.find(params[:id])
      @example_group.destroy
      
      head :ok
    rescue => e
      Rails.logger.error e
      head :not_found
    end
  end
end
