class ExamplesController < ApplicationController
  respond_to :json
  
  # GET /examples.json
  def index
    @examples = Example.all
    
    respond_with @examples
  end
  
  # GET /examples/1.json
  def show
    begin
      @example = Example.find(params[:id])
      
      respond_with @example
    rescue => e
      Rails.logger.error e
      render :text => 'Invalid params.', :status => :bad_request
    end
  end
  
  # POST /examples.json
  def create
    begin
      raise unless params.has_key?(:example)
      
      @example = if params[:example].has_key?(:example_group_id) && !params[:example][:example_group_id].nil?
        example_group_id = params[:example].delete(:example_group_id)
        
        # example_group = ExampleGroup.find(example_group_id)
        # example = example_group.examples.create( params[:example] )
        # example_group.save
        # 
        # example
        
        ExampleGroup.find(example_group_id).examples.create( params[:example] )
      else
        Example.create( params[:example] )
      end
      
      # @example = Example.create( params[:example] )
      
      respond_with @example
    rescue => e
      Rails.logger.error e
      render :text => 'Invalid params.', :status => :bad_request
    end
  end
  
  # PUT /examples/1.json
  def update
    begin
      @example = Example.find(params[:id])
      @example.update_attributes(params[:example])
      
      respond_with @example
    rescue => e
      Rails.logger.error e
      render :text => 'Invalid params.', :status => :bad_request
    end
  end
  
  # DELETE /examples/1.json
  def destroy
    begin
      @example = Example.find(params[:id])
      @example.destroy
      
      head :ok
    rescue => e
      Rails.logger.error e
      head :not_found
    end
  end
end
