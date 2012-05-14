require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'database_cleaner'
  
  DatabaseCleaner.strategy = :truncation
  
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| load f }
  
  RSpec.configure do |config|
    config.mock_with :mocha
    config.infer_base_class_for_anonymous_controllers = false
    
    config.include ControllerHelpers, type: :controller
    
    config.before :suite do
      system 'clear'
      DatabaseCleaner.start
    end
    
    config.after :suite do
      DatabaseCleaner.clean
    end
  end
end

Spork.each_run do
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| load f }
end
