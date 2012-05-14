require 'spec_helper'

describe ClientsController, type: :controller do
  before :all do
    Client.create(name: 'foobar')
  end
  
  describe "GET /clients.json" do
    specify "it should return all Clients" do
      json_request :index
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Client.all)
    end
  end
  
  describe "GET /clients/1.json" do
    specify "With valid params, it should return the client" do
      json_request :show, id: 1
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Client.first)
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :show, name: 'foobar'
      
      response.should_not be_successful
    end
  end
  
  describe "POST /clients.json" do
    specify "With valid params, it should return the newly created client" do
      json_request :create, { client: { name: 'new' } }
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Client.where(name: 'new').first)
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :create, { client: { age: 13 } }
      
      response.should_not be_successful
    end
  end
  
  describe "PUT /clients/1.json" do
    specify "With valid params, it should return the newly updated client" do
      json_request :update, { id: '1', client: { name: 'foobaz' } }
      
      response.should be_successful
      response.should be_valid_json
      response.should have_json_body_of(Client.where(name: 'foobaz').first)
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :update, { client: { age: 13 } }
      
      response.should_not be_successful
    end
  end
  
  describe "DELETE /clients/1.json" do
    specify "With valid params, it should return be successful" do
      json_request :destroy, { id: '1' }
      
      response.should be_successful
      Client.exists?(1).should be_false
    end
    
    specify "With invalid params, it should not be successful" do
      json_request :destroy, { name: 'foobar' }
      
      response.should_not be_successful
      Client.exists?(2).should_not be_false
    end
  end
end