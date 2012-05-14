require 'spec_helper'

describe ProjectsController, type: :controller do
  before :all do
    Project.create(name: 'foobar')
  end
  
  describe "GET /projects.json" do
    specify "it should return all Projects" do
      json_request :index
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Project.all)
    end
  end
  
  describe "GET /projects/1.json" do
    specify "With valid params, it should return the project" do
      json_request :show, id: 1
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Project.first)
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :show, name: 'foobar'
      
      response.should_not be_successful
    end
  end
  
  describe "POST /projects.json" do
    specify "With valid params, it should return the newly created project" do
      json_request :create, { project: { name: 'new' } }
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Project.where(name: 'new').first)
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :create, { project: { age: 13 } }
      
      response.should_not be_successful
    end
  end
  
  describe "PUT /projects/1.json" do
    specify "With valid params, it should return the newly updated project" do
      json_request :update, { id: '1', project: { name: 'foobaz' } }
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Project.where(name: 'foobaz').first)
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :update, { project: { age: 13 } }
      
      response.should_not be_successful
    end
  end
  
  describe "DELETE /projects/1.json" do
    specify "With valid params, it should return be successful" do
      json_request :destroy, { id: '1' }
      
      response.should be_successful
      Project.exists?(1).should be_false
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :destroy, { name: 'foobar' }
      
      response.should_not be_successful
      Project.exists?(2).should_not be_false
    end
  end
end