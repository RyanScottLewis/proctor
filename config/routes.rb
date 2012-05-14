Proctor::Application.routes.draw do
  root to: 'home#index'
  
  resources :clients, format: :json, except: [:new, :edit]
  resources :projects, format: :json, except: [:new, :edit]
  resources :iterations, format: :json, except: [:new, :edit, :update]
  resources :example_groups, format: :json, except: [:new, :edit, :update]
  resources :examples, format: :json, except: [:new, :edit, :update]
  
  faye_server '/faye', :timeout => 25 do
    ['Client', 'Project', 'Iteration', 'Example', 'ExampleGroup'].each do |model_class|
      map "/#{model_class.pluralize.underscore}/create" => WebSocketController
      map "/#{model_class.pluralize.underscore}/update" => WebSocketController
      map "/#{model_class.pluralize.underscore}/destroy" => WebSocketController
    end
    
    map :default => :block # message will be returned with the error "Permission denied."
  end
end
