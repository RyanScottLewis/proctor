require 'spec_helper'

describe IterationsController, type: :controller do
  before :all do
    Iteration.create
  end
  
  describe "GET /iterations.json" do
    specify "it should return all Iterations" do
      json_request :index
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Iteration.all)
    end
  end
  
  describe "GET /iterations/1.json" do
    specify "With valid params, it should return the iteration" do
      json_request :show, id: 1
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Iteration.first)
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :show, name: 'foobar'
      
      response.should_not be_successful
    end
  end
  
  describe "POST /iterations.json" do
    specify "With valid params, it should return the newly created iteration" do
      json_request :create
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Iteration.find(2))
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :create, { iteration: { age: 13 } }
      
      response.should_not be_successful
    end
  end
  
  describe "DELETE /iterations/1.json" do
    specify "With valid params, it should return be successful" do
      json_request :destroy, { id: '1' }
      
      response.should be_successful
      Iteration.exists?(1).should be_false
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :destroy, { name: 'foobar' }
      
      response.should_not be_successful
      Iteration.exists?(2).should_not be_false
    end
  end
end