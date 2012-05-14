require 'spec_helper'

describe ExamplesController, type: :controller do
  before :all do
    Example.create(description: 'foobar')
  end
  
  describe "GET /example.json" do
    specify "it should return all Examples" do
      json_request :index
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Example.all)
    end
  end
  
  describe "GET /example/1.json" do
    specify "With valid params, it should return the example" do
      json_request :show, id: 1
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Example.first)
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :show, description: 'foobar'
      
      response.should_not be_successful
    end
  end
  
  describe "POST /example.json" do
    specify "With valid params, it should return the newly created example" do
      json_request :create, { example: { description: 'new' } }
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Example.where(description: 'new').first)
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :create, { example: { age: 13 } }
      
      response.should_not be_successful
    end
  end
  
  describe "PUT /example/1.json" do
    specify "With valid params, it should return the newly updated example" do
      json_request :update, { id: '1', example: { description: 'foobaz' } }
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Example.where(description: 'foobaz').first)
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :update, { example: { age: 13 } }
      
      response.should_not be_successful
    end
  end
  
  describe "DELETE /example/1.json" do
    specify "With valid params, it should return be successful" do
      json_request :destroy, { id: '1' }
      
      response.should be_successful
      Example.exists?(1).should be_false
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :destroy, { description: 'foobar' }
      
      response.should_not be_successful
      Example.exists?(2).should_not be_false
    end
  end
end