require 'spec_helper'

describe ExampleGroupsController, type: :controller do
  before :all do
    ExampleGroup.create(description: 'foobar')
  end
  
  describe "GET /example_groups.json" do
    specify "it should return all ExampleGroups" do
      json_request :index
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(ExampleGroup.all)
    end
  end
  
  describe "GET /example_groups/1.json" do
    specify "With valid params, it should return the example_group" do
      json_request :show, id: 1
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(ExampleGroup.first)
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :show, description: 'foobar'
      
      response.should_not be_successful
    end
  end
  
  describe "POST /example_groups.json" do
    specify "With valid params, it should return the newly created example_group" do
      json_request :create, { example_group: { description: 'new' } }
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(ExampleGroup.where(description: 'new').first)
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :create, { example_group: { age: 13 } }
      
      response.should_not be_successful
    end
  end
  
  describe "PUT /example_groups/1.json" do
    specify "With valid params, it should return the newly updated example_group" do
      json_request :update, { id: '1', example_group: { description: 'foobaz' } }
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(ExampleGroup.where(description: 'foobaz').first)
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :update, { example_group: { age: 13 } }
      
      response.should_not be_successful
    end
  end
  
  describe "DELETE /example_groups/1.json" do
    specify "With valid params, it should return be successful" do
      json_request :destroy, { id: '1' }
      
      response.should be_successful
      ExampleGroup.exists?(1).should be_false
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :destroy, { description: 'foobar' }
      
      response.should_not be_successful
      ExampleGroup.exists?(2).should_not be_false
    end
  end
end